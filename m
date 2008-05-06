From: "Chris Smith" <smitty1elkml@gmail.com>
Subject: Re: ata-piix booting woes
Date: Tue, 6 May 2008 07:17:27 -0400
Message-ID: <9b53a56d0805060417x42f92604v6b963bae94f9b27b@mail.gmail.com>
References: <C4E7938E-5F8F-4732-8A20-D3B6BDB044D6@teqcle.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:46697 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYEFLR2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 07:17:28 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1630466rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 06 May 2008 04:17:28 -0700 (PDT)
In-Reply-To: <C4E7938E-5F8F-4732-8A20-D3B6BDB044D6@teqcle.co.za>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johan van den Berg <johanvdb@teqcle.co.za>
Cc: linux-ide@vger.kernel.org

On 5/5/08, Johan van den Berg <johanvdb@teqcle.co.za> wrote:
> I have been having issues booting into 2.6.26-rc1 using ata-piix
>
[snip]
> [   75.689722] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised:
> dm-devel@redhat.com
> [   78.211210] Kernel panic - not syncing: Attempted to kill init!
>
> The failure happens in initrd, as it is unable to find and mount the new
> root. As you can see it is actually reading the partition table, so I am not
> sure why lvm would not pick up the volume group. Rebooting into an older
> 2.6.15 kernel consistently works whereas the 2.6.25 consistently fails.
>
> I think this might related to
> http://lists.openwall.net/linux-kernel/2007/05/29/100 where
> it was already isolated it to the controller not liking the SRST sequence.
>
> I have tried disabling IDE (BIOS / recompile without IDE support), have
> tried various combinations of older kernels with newer drivers and vice
> versa, but the shared ata code is too complex for me to patch per driver.
>
> Has there been any progress on this so far?
>
> Johan van den Berg
> Managing Director
> Teqcle Information Technologies (Pty.) Ltd.
>
> Email: johanvdb@teqcle.co.za
> Cel: 0732013520

I don't see my post to this list of last night, but I am having a
similar issue with an Intel SATA IDE ICH7 drive in a Dell D620 laptop
that uses ata-piix.
Last good kernel was gentoo-2.6.25-rc8-git3
Bringing /proc/config forward to the latest git tree, and looking at
the missing symbols in the terminal window after a make menuconfig,
there was something about a CONFIG_IDE_DEPRECATED that was not carried
forward.
I'll find the specifics after I get home from work.
Promises to be a fine introduction to bisecting.

-- 
Christopher Smith
Pursuer of knowledge
