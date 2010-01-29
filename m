From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [kekcsibe@gmail.com: PROBLEM: Pioneer DVD-RW DVR-112D does not
 work since linux 2.6.29]
Date: Fri, 29 Jan 2010 13:43:05 -0600
Message-ID: <4B633A49.8000700@gmail.com>
References: <20100129044834.GB25869@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f182.google.com ([209.85.221.182]:40282 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab0A2TnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 14:43:10 -0500
Received: by qyk12 with SMTP id 12so1047596qyk.21
        for <linux-ide@vger.kernel.org>; Fri, 29 Jan 2010 11:43:09 -0800 (PST)
In-Reply-To: <20100129044834.GB25869@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kekcsibe@gmail.com
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-ide <linux-ide@vger.kernel.org>

On 01/28/2010 10:48 PM, Borislav Petkov wrote:
> Hi Skrab=C3=A1k,
>
> I'm forwarding your mail to linux-ide where all those issues should b=
e
> reported. Also, it would be helpful if you sent the whole dmesg outpu=
t
> of the failing kernel.
>
> Reattaching your files too.
>
> Thanks.
>
> ----- Forwarded message from Skrabak Csaba<kekcsibe@gmail.com>  -----
>
> From: Skrabak Csaba<kekcsibe@gmail.com>
> To: Borislav Petkov<petkovbb@gmail.com>
> Date: Fri, 29 Jan 2010 04:27:08 +0100
> Subject: PROBLEM: Pioneer DVD-RW DVR-112D does not work since linux 2=
=2E6.29
> Message-ID:<b7a1ac7c1001281927g13323d38tcd71271aee0137ca@mail.gmail.c=
om>
>
> Dear Maintainer,
>
> I have found your e-mail address in the MAINTAINERS file of the linux
> kernel 2.6.32.6 source.
>
> I have a problem getting my DVD recorder working. I have been using
> 2.6.22 with no problem at all. Later I have tried 2.6.29, which
> produced funny issues: booting up netinstaller CD worked just fine,
> but when coming to loading the drivers, DVD stopped working, so it
> could not install the packages. I also tried a Windows XP install CD,
> which also booted fine, but after installing, Windows could not use
> the drive. I kept on using the old 2.6.22 linux. But the newest
> versions of udev and other packages found in Debian unstable
> repositories don't seem to be compatible any longer with my old but
> working kernel. So I decided to try if the problem has been fixed in
> 2.6.32.6 and my DVD drive could work again like it does with 2.6.22.
> Now I experience the same problems, which in detail are:
>
> Mount outputs attached dvd.txt and does not mount. Gnome also does no=
t
> mount CD-ROM Device (shows error message).
>
=2E..


>
> Can it be that my DVD drive has in fact a minor defect, but the old
> 2.6.22 kernel driver just overlooked that? Were there any changes in
> the driver since then that could make the driver pickier? Can I do
> something to overcome it (maybe a config parameter, fstab corrections=
,
> udev reconfiguration) or must I wait until a new kernel version comes=
?
>
> Using web search I found plenty of questions dealing with the same
> error message but all they could answer was that the DVD was dead. Bu=
t
> it is definitely not.
>
> Please tell me if you know something that or somebody who could help
> me solving my problem.

Here's your output:

kazimir:~# mount /cdrom
sr 1:0:0:0: [sr0] Result: hostbyte=3D0x00 driverbyte=3D0x08
sr 1:0:0:0: [sr0] Sense Key : 0x5 [current]
sr 1:0:0:0: [sr0] <<vendor>> ASC=3D0xa8 ASCQ=3D0x1ASC=3D0xa8 ASCQ=3D0x1
sr 1:0:0:0: [sr0] CDB: cdb[0]=3D0x28: 28 00 00 00 00 10 00 00 02 00
end_request: I/O error, dev sr0, sector 64
Buffer I/O error on device sr0, logical block 8

The kernel tried to read some sectors off the disk (command 0x28) and=20
the drive returned an error. ASC of 0xa8 is a vendor-specific error=20
code, so only Pioneer can likely say what that error means.

You're sure that 2.6.22 is still able to successfully access this drive=
?=20
Any unusual dmesg output there?

  The fact that it doesn't seem to work properly in Windows either does=
=20
seem to suggest a drive fault.
