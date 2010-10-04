From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bug#598518: linux-image-2.6-686: ata_piix module loaded before
 ahci module deactivate hotplug support (regression from lenny)
Date: Mon, 04 Oct 2010 18:46:51 +0200
Message-ID: <4CAA04FB.7070402@gmail.com>
References: <20100929165034.21331.69639.reportbug@albatros.savanenet> <1285799230.28504.105.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62072 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab0JDQqz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2010 12:46:55 -0400
Received: by fxm4 with SMTP id 4so72043fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 04 Oct 2010 09:46:54 -0700 (PDT)
In-Reply-To: <1285799230.28504.105.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: thomas.debesse+debian@gmail.com, 598518@bugs.debian.org, linux-ide@vger.kernel.org

Hello,

On 09/30/2010 12:27 AM, Ben Hutchings wrote:
> On Wed, 2010-09-29 at 18:50 +0200, thomas.debesse+debian@gmail.com
> wrote:
> [...]
>> ICH6 sata controller could be managed by both ata_piix and ahci module but only
>> ahci module handle hotplug.
>> At boot time, when ata_piix is loaded before ahci module, it takes control of
>> the ICH6 controller and the ahci module does'nt manage nothing. Because
>> ata_piix also manage ICH6 sata controller, hard drives are managed, but because
>> ata_piix module is used in place of ahci module, because ahci module is'nt
>> used, hotplug (and other ahci functionnalities indeed) does'nt works.
> [...]
>> The solution is to load ahci module before ata_piix module, then we can have
>> SATA drives managed by ahci module and IDE drives managed by ata_piix module.
> [...]
> 
> You can force ahci to be loaded first:
> 1. Add the line 'ahci' to /etc/initramfs-tools/modules.
> 2. Run 'update-initramfs -u' to regenerate the initramfs.
> 3. Reboot.
> 
> But it seems like it would be better if ahci was automatically
> preferred.

With modules.order in place, modprobe will always prefer ahci over
ata_piix (the preference follows the link order).  Maybe debian initrd
doesn't handle modules.order properly?

Thanks.

-- 
tejun
