From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding crazy head unloads
Date: Mon, 09 Jun 2008 10:56:35 +0900
Message-ID: <484C8DD3.60502@gmail.com>
References: <48361F88.7040400@gmail.com> <1212400554.16559.33.camel@wing-commander>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:55455 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbYFIB4n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jun 2008 21:56:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1893554wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 08 Jun 2008 18:56:42 -0700 (PDT)
In-Reply-To: <1212400554.16559.33.camel@wing-commander>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott James Remnant <scott@ubuntu.com>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, roland.kletzing@materna.de, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Scott James Remnant wrote:
> On Fri, 2008-05-23 at 10:36 +0900, Tejun Heo wrote:
> 
>> Attached are storage-fixup script which is to be called during boot and 
>> resume and configuration file to go under /etc.  The script can match 
>> dmi and hal properties and execute commands on the matching devices. 
>> The config file currently only contains three rules.
>>
> Could this not be done better inside HAL itself?

Could be.  I really don't know about HAL.  There were several problems 
w/ HAL and I had to drop HAL dependency tho.  HAL depends on a lot of 
things and thus is started too late which makes it impossible to use in 
early stages of boot (e.g. single mode).  Another problem was that HAL 
currently uses truncated ATA model ID string reported through SCSI 
layer.  The updated version is in the following git tree.

http://git.kernel.org/?p=linux/kernel/git/tj/storage-fixup.git;a=shortlog;h=master

If there's any better way to deal with this, I'll be happy to drop the 
ugly script.

Thanks.

-- 
tejun
