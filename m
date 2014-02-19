From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 00/18] ahci: library-ise ahci_platform,
 add sunxi driver and cleanup imx driver
Date: Wed, 19 Feb 2014 11:20:36 -0600
Message-ID: <CAOCHtYgOZ_L+XeZnT0Sed7oLv=65meFSr15zJ8odqr0F+xPTxg@mail.gmail.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=bcaec50b513c68feac04f2c59b2e
Return-path: <linux-sunxi+bncBDCZ7T7K3YORBDOUSOMAKGQEJ3DVZHI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-IDE <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

--bcaec50b513c68feac04f2c59b2e
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Feb 19, 2014 at 6:01 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi all,
>
> Here is v6 of my patchset for adding ahci-sunxi support. This has been
> tested with Allwinner A10, Allwinner A20 and Freeware imx6x SoCs, including
> suspend / resume. Note that since my last revision the ahci_imx driver has
> also grown imx53 sata support, it would be good if some-one could test that
> with this series.
>

basic file system tests on an imx53-qsb look fine with sata changes..

Using v3.14-rc3 + 20140219 (next) + shawn.guo's imx for-next branch which
wasn't in today next tree..

debian@arm:~$ dmesg | grep ata
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Memory: 1010076K/1048576K available (7008K kernel code, 527K
rwdata, 2280K rodata, 416K init, 373K bss, 38500K reserved, 524288K highmem)
[    0.000000]       .data : 0xc0984000 - 0xc0a07d60   ( 528 kB)
[    1.796587] libata version 3.00 loaded.
[    2.777037] ahci-imx 10000000.sata: unable to find phy
[    2.784385] ahci-imx 10000000.sata: SSS flag set, parallel bus scan
disabled
[    2.791495] ahci-imx 10000000.sata: AHCI 0001.0100 32 slots 1 ports 3
Gbps 0x1 impl platform mode
[    2.800394] ahci-imx 10000000.sata: flags: ncq sntf stag pm led clo only
pmp pio slum part ccc
[    2.814178] ata1: SATA max UDMA/133 mmio [mem 0x10000000-0x10000fff]
port 0x100 irq 44
[    3.400107] ata1: softreset failed (device not ready)
[    3.405174] ata1: applying PMP SRST workaround and retrying
[    3.610105] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.663654] ata1.00: ATA-8: ST9120315AS, 0001SDM1, max UDMA/133
[    3.669583] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    3.678553] ata1.00: configured for UDMA/133
[    5.680633] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data
mode. Opts: (null)

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.

--bcaec50b513c68feac04f2c59b2e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Wed, Feb 19, 2014 at 6:01 AM, Hans de Goede <span dir=3D"ltr">&l=
t;<a href=3D"mailto:hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">hdegoede@redhat.=
com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hi all,<br>
<br>
Here is v6 of my patchset for adding ahci-sunxi support. This has been<br>
tested with Allwinner A10, Allwinner A20 and Freeware imx6x SoCs, including=
<br>
suspend / resume. Note that since my last revision the ahci_imx driver has<=
br>
also grown imx53 sata support, it would be good if some-one could test that=
<br>
with this series.<br></blockquote><div><br></div><div>basic file system tes=
ts on an imx53-qsb look fine with sata changes..</div><div><br></div><div>U=
sing v3.14-rc3 +=A020140219 (next) + shawn.guo&#39;s imx=A0for-next branch =
which wasn&#39;t in today next tree..</div>
<div><br></div><div><div>debian@arm:~$ dmesg | grep ata</div><div>[ =A0 =A0=
0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instructio=
n cache</div><div>[ =A0 =A00.000000] Memory policy: Data cache writeback</d=
iv><div>
[ =A0 =A00.000000] Memory: 1010076K/1048576K available (7008K kernel code, =
527K rwdata, 2280K rodata, 416K init, 373K bss, 38500K reserved, 524288K hi=
ghmem)</div><div>[ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc0984000 - 0xc0a0=
7d60 =A0 ( 528 kB)</div>
<div>[ =A0 =A01.796587] libata version 3.00 loaded.</div><div>[ =A0 =A02.77=
7037] ahci-imx 10000000.sata: unable to find phy</div><div>[ =A0 =A02.78438=
5] ahci-imx 10000000.sata: SSS flag set, parallel bus scan disabled</div><d=
iv>[ =A0 =A02.791495] ahci-imx 10000000.sata: AHCI 0001.0100 32 slots 1 por=
ts 3 Gbps 0x1 impl platform mode</div>
<div>[ =A0 =A02.800394] ahci-imx 10000000.sata: flags: ncq sntf stag pm led=
 clo only pmp pio slum part ccc=A0</div><div>[ =A0 =A02.814178] ata1: SATA =
max UDMA/133 mmio [mem 0x10000000-0x10000fff] port 0x100 irq 44</div><div>[=
 =A0 =A03.400107] ata1: softreset failed (device not ready)</div>
<div>[ =A0 =A03.405174] ata1: applying PMP SRST workaround and retrying</di=
v><div>[ =A0 =A03.610105] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl=
 300)</div><div>[ =A0 =A03.663654] ata1.00: ATA-8: ST9120315AS, 0001SDM1, m=
ax UDMA/133</div>
<div>[ =A0 =A03.669583] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (de=
pth 31/32)</div><div>[ =A0 =A03.678553] ata1.00: configured for UDMA/133</d=
iv><div>[ =A0 =A05.680633] EXT4-fs (mmcblk0p2): mounted filesystem with ord=
ered data mode. Opts: (null)</div>
</div><div><br></div><div>Regards,</div></div><div><br></div>-- <br>Robert =
Nelson<br><a href=3D"http://www.rcn-ee.com/">http://www.rcn-ee.com/</a>
</div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

--bcaec50b513c68feac04f2c59b2e--
