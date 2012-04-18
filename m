From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Wed, 18 Apr 2012 09:29:47 +0800
Message-ID: <1334712587.11188.139.camel@minggr>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com>
	 <4F8DD939.1050909@pobox.com> <4F8DDB24.9080109@teksavvy.com>
	 <4F8DDC4F.8060103@pobox.com> <4F8DDDC0.2010609@teksavvy.com>
	 <CAF1ivSbEWJ18vV1ZqTnzWuZ5AXKwj+0pPPzCWUmnT_JKwKKQ2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58486 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab2DRB3s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2012 21:29:48 -0400
In-Reply-To: <CAF1ivSbEWJ18vV1ZqTnzWuZ5AXKwj+0pPPzCWUmnT_JKwKKQ2w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel@teksavvy.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org


> On 12-04-17 05:10 PM, Jeff Garzik wrote:
> > On 04/17/2012 05:05 PM, Mark Lord wrote:
> >> On 12-04-17 04:57 PM, Jeff Garzik wrote:
> >>> On 04/17/2012 04:48 PM, Mark Lord wrote:
> >>>> On 12-04-17 04:38 PM, Mark Lord wrote:
> >>>>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
> >>>>> I don't know when it stopped working, but it's a blooming pain in the sysadmin.
> >>>>>
> >>>>> I need to hotplug a SATA drive into an AHCI port,
> >>>>> preferably without having to reboot first.
> >>>>>
> >>>>> Is there a patch available already for this regression?
> >>>>
> >>>>
> >>>> Answering my own question, this patch appears to address the issue.
> >>>> I'll test and report back again shortly:
> >>>>
> >>>>       http://patchwork.ozlabs.org/patch/146326/
> >>>>
> >>>> Odd that it's been sitting in various people's inboxes since 3.3-rc1
> >>>> and hasn't been pushed out yet.
> >>>
> >>> The vast majority of "hotpluggable" ports are not necessarily covered by this patch.
> >>
> >>
> >> And what majority of ports are currently broken by linux-3.3 ?
> >> Any idea of what the offending commit may have been,
> >> so I can test against that and perhaps get it reverted then?
> >>
> >> So far, my sample of three systems are all broken with this kernel.
> >> That's definitely "regression" territory.  :)
> >
> > Right -- rather than breaking a bunch and fixing a few, we might just need to revert the runtime pm
> > stuff altogether.
> >
> > Commits to look at include
> >
> >     966f1212e1ac5fe3ddf04479d21488ddb36a2608
> >     33574d68ae41ccbc6686cfabd965c685285c58a0
> >     e90b1e5a6e04c8892007ff8db20ef6d4fbdb5402
> >     9ee4f3933930abf5cc34f8e9d69fe0e08c18f602
> >     5ef41082912bdfcb33fa53b8dba2ad17dea2ef90
> >     9a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a
> >
> 
> Or perhaps there's a simpler solution/patch, maybe a one-liner
> to change the boot-up default to "no runtime PM until enabled" or something.
> 
> Probably less risky if the changes are as pervasive as you suggest.

Hi Mark,

I'm working on the hotplug issue fix.

Before the fix is ready, here is the one-line patch.
Could you give it a try?

Thanks.

>From 06aa5b161ea8d94c222deb572f6628c8dda49939 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Wed, 18 Apr 2012 09:13:41 +0800
Subject: [PATCH] libata: forbid port runtime pm by default

Forbid port runtime pm by default because it has known hotplug issue.
User can allow it by, for example

echo auto > /sys/devices/pci0000:00/0000:00:1f.2/ata2/power/control

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/ata/libata-transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 74aaee3..c341904 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
 	device_enable_async_suspend(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
+	pm_runtime_forbid(dev);
 
 	transport_add_device(dev);
 	transport_configure_device(dev);
-- 
1.7.2.5




