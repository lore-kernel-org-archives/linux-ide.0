From: Mark Nelson <mdnelson8@gmail.com>
Subject: Re: [PATCH] ahci: add parameter to disable ahci driver on Promise
	PDC42819
Date: Wed, 11 Nov 2009 22:35:21 +1100
Message-ID: <65a6ef750911110335m55210d6ci247d03c21a529eb2@mail.gmail.com>
References: <65a6ef750911110154h4eff3b9cp4f5259f37834ea7a@mail.gmail.com>
	 <20091111103701.11a9d96e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:43216 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbZKKLfQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Nov 2009 06:35:16 -0500
Received: by ey-out-2122.google.com with SMTP id 9so220765eyd.19
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2009 03:35:21 -0800 (PST)
In-Reply-To: <20091111103701.11a9d96e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Alan,

On Wed, Nov 11, 2009 at 9:37 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 11 Nov 2009 20:54:34 +1100
> Mark Nelson <mdnelson8@gmail.com> wrote:
>
>> ahci can drive the Promise PDC42819, but obviously it can only use SATA
>> disks connected to this controller. The controller can actually support
>> SAS disks as well, but at the moment only with Promise's own binary
>> t3sas driver.
>
> That would be a promise problem.

It is Promise's problem but seeing as I was the one who added support
for this Promise chip to the ahci driver I felt responsible for the
complaints from people who try to load the driver only to find that it
doesn't work because ahci has grabbed the device; leaving them to
patch and recompile their kernel to be able to use their SAS disks.

>
>> To allow users to use both the ahci and the t3sas drivers in the same
>
> But you said it was a binary driver, so how can you use it. The kernel is
> GPL licensed ?

The driver looks to be the same as all the other binary drivers around
- an open source shim around some proprietary blob (which in theory
might be shared with their other drivers I guess...).

I would personally love to see an open source SAS driver for this chip,
but I'm told that without any documentation from Promise it would be
virtually impossible to create one. Forgive the sidetrack question, but
with tools like mmiotrace and a working binary driver to use it on (and
the knowledge that it has an AHCI mode), how hard would it be?

In retrospect I should have probably put an RFC on the patch because I
wasn't sure if this would be frowned upon, even if it might help a few
users.

Thanks!
Mark
