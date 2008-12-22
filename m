From: Badalian Vyacheslav <slavon@bigtelecom.ru>
Subject: Re: Red leds at harddisk bays on SR1530HSH after update to 2.6.27.x
Date: Mon, 22 Dec 2008 10:10:53 +0300
Message-ID: <494F3D7D.9010002@bigtelecom.ru>
References: <494A34CA.9030906@bigtelecom.ru> <20081219223246.b0aea84d.akpm@linux-foundation.org> <494EF9A1.90002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753783AbYLVHLP@vger.kernel.org>
In-Reply-To: <494EF9A1.90002@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Andrew Morton wrote:
>  =20
>> (cc linux-ide)
>>
>> On Thu, 18 Dec 2008 14:32:26 +0300 Badalian Vyacheslav <slavon@bigte=
lecom.ru> wrote:
>>
>>    =20
>>> Hello all.
>>> After update from 2.6.26 to 2.6.27 all leds at drive bays now red.
>>> SATA controller in AHCI mode.
>>> Platform is Intel SR1530HSH
>>>
>>> Config attached.
>>>
>>> Any patches for test? Any ideas? Any other info needed? Or i must g=
o to
>>> bugtracker? ;)
>>>      =20
>
> Does ahci.ahci_em_messages=3D0 help?
>
>  =20
Hello!

echo 0 > /sys/module/ahci/parameters/ahci_em_messages
-bash: /sys/module/ahci/parameters/ahci_em_messages: Permission denied
ls -la /sys/module/ahci/parameters/ahci_em_messages
-r--r--r-- 1 root root 4096 Dec 22 10:04
/sys/module/ahci/parameters/ahci_em_messages

Any other chance to change without it reboot? Or i can change it only a=
t
boot? I will reboot server at night.


Vyacheslav
