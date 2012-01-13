From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH v2 0/3] ahci controller runtime PM support
Date: Fri, 13 Jan 2012 10:17:23 +0800
Message-ID: <CAF1ivSbwO+D1Z4A=A7wPunDOOkZxthRAn_TEX_osyJozdZNFcg@mail.gmail.com>
References: <1324964554-9719-1-git-send-email-ming.m.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54220 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101Ab2AMCRY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jan 2012 21:17:24 -0500
In-Reply-To: <1324964554-9719-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Dec 27, 2011 at 1:42 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> Hi all,
>
> Here is the v2 patches to add ahci controller runtime PM support.
> Applied on top of linux-next tree.
>
> Thanks for any comments.

Any comment?

Thanks,
Lin Ming

>
> v2:
> - add ahci hibernate callbacks
>
> v1:
> https://lkml.org/lkml/2011/12/15/198
>
> Lin Ming (3):
> =A0 =A0 =A0ahci: port legacy pm interface to struct dev_pm_ops
> =A0 =A0 =A0ahci: add runtime PM callbacks
> =A0 =A0 =A0ata: runtime suspend port if no device attached
>
> =A0drivers/ata/ahci.c =A0 =A0 =A0 =A0| =A0 71 +++++++++++++++++++++++=
++++++++++++++++-----
> =A0drivers/ata/libata-core.c | =A0 21 ++++++++++++-
> =A02 files changed, 83 insertions(+), 9 deletions(-)
>
