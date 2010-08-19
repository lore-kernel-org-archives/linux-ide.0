From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 13:35:32 +0200
Message-ID: <1282217732.1236.19.camel@yio.site>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	 <4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>
	 <4C6AB919.7060203@kernel.org>	<20100817180158.179e7780@lxorguk.ukuu.org.uk>
	 <4C6ABFFA.2000502@kernel.org>	<20100817192353.3529733c@lxorguk.ukuu.org.uk>
	 <4C6B7B72.4090405@kernel.org>	<20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
	 <4C6BE9C8.4030803@kernel.org>	<20100818161521.430ba361@lxorguk.ukuu.org.uk>
	 <4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com>
	 <4C6D13E2.1010703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49471 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab0HSLfK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2010 07:35:10 -0400
Received: by bwz11 with SMTP id 11so1078296bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 19 Aug 2010 04:35:08 -0700 (PDT)
In-Reply-To: <4C6D13E2.1010703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org

On Thu, 2010-08-19 at 13:22 +0200, Tejun Heo wrote:
> Kay, there are a few ATA drivers with overlapping hardware support.
> When all the drivers are built-in the kernel or none of them is loaded
> as modules, priority among them as defined by link order is followed;
> however, if one of the drivers is already loaded while other
> overlapping ones are not, there's nothing which guarantees driver
> probing would happen after modprobe for the device ID is complete,

Not sure it if I get it right. You mean the first driver binds to the
device already, right? But you want the later one to be used?

Any driver that binds to a device will prevent any other later loaded
driver from binding to, or handling the device. The only way to have the
second driver seeing the device is unbinding the first driver in sysfs,
and binding the second one in sysfs.

Kay

