From: Ezaul Zillmer <ezaulzillmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH RFC v4 00/10] ahci: library-ise
 ahci_platform, add sunxi driver and cleanup imx driver
Date: Tue, 21 Jan 2014 05:15:32 -0800 (PST)
Message-ID: <7defeeb5-d7c8-4b9c-8e5e-f31dafc32eeb@googlegroups.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com> <b8dd9fd4-02ce-4656-8b92-49f2ab82cc69@googlegroups.com>
 <52DE288C.3020007@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1699_2606243.1390310132875"
Return-path: <linux-sunxi+bncBD2ILSOUX4CBB5PF7GLAKGQEV4JWRSI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52DE288C.3020007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

------=_Part_1699_2606243.1390310132875
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

LINUX-SUNXI
[core]
repositoryformatversion =3D 0
filemode =3D true
bare =3D false
logallrefupdates =3D true
[remote "origin"]
fetch =3D +refs/heads/*:refs/remotes/origin/*
url =3D https://github.com/jwrdegoede/linux-sunxi.git
[branch "sunxi-devel"]
remote =3D origin
merge =3D refs/heads/sunxi-devel



U-BOOT
[core]
repositoryformatversion =3D 0
filemode =3D true
bare =3D false
logallrefupdates =3D true
[remote "origin"]
fetch =3D +refs/heads/*:refs/remotes/origin/*
url =3D https://github.com/jwrdegoede/u-boot-sunxi.git
[branch "sunxi-next"]
remote =3D origin
merge =3D refs/heads/sunxi-next


CONFIG_AHCI_SUNXI=3Dy

Just took a git pull recompiled the kernel, modules and dtb sent MicroSD=20
pro=20
and not simply booted the Sata UP more ... al had a copy before the git=20
pull recompiled sent to regular MicroSD he recognizes the HD and do nothing=
=20
except change the dtb and former Kernek! what could it be?=20

Hug!


## Booting kernel from Legacy Image at 46000000 ...
   Image Name:   Linux-3.13.0-rc7-52420-g41aabcc
   Created:      2014-01-21  11:58:18 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    5404880 Bytes =3D 5.2 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 49000000
   Booting using the fdt blob at 0x49000000
   Loading Kernel Image ... OK
   Using Device Tree in place at 49000000, end 49007097





Em ter=C3=A7a-feira, 21 de janeiro de 2014 05h58min04s UTC-2, Hans de Goede=
=20
escreveu:
>
> Hi,=20
>
> On 01/20/2014 08:53 PM, Ezaul Zillmer wrote:=20
> > hi Hans=20
> >=20
> > First wanted to thank his work with sunxi ... as they say here in Brazi=
l=20
> you're the guy !=20
> >=20
> > I noticed the following after your upgrade .. 01/20/2014 my ATA does no=
t=20
> look rose more !=20
> > # # # # Here before UP ! # # # # #=20
> >=20
> > Image Name : Linux - 3.13.0 - rc7=20
> >=20
> > [ 1.150317 ] 8021Q : 802.1Q VLAN Support v1.8=20
> > [ 1.154585 ] Key type dns_resolver registered=20
> > [ 1.159130 ] Registering SWP / SWPB emulation handler=20
> > [ 1.165146 ] ahci - 5v : 5000 mV=20
> > [ 1.168509 ] usb1 - VBUS : 5000 mV=20
> > [ 1.172082 ] usb2 - VBUS : 5000 mV=20
> > [ 1.200799 ] ahci sunxi - 1c18000.ahci : controller can not do PMP ,=20
> turning off CAP_PMP=20
> > [ 1.208303 ] sunxi 1c18000.ahci - ahci : forcing PORTS_IMPL to 0x1=20
> > [ 1.214179 ] sunxi 1c18000.ahci - ahci : AHCI 0001.0100 32 slots 1 port=
s=20
> 3 Gbps 0x1 impl sunxi mode=20
> > [ 1.222903 ] sunxi 1c18000.ahci - ahci : flags : NCQ SNTF pm led clo pi=
o=20
> slum part ccc only=20
> > [ 1.231594 ] scsi0 : sunxi_ahci=20
> > [ 1.234955 ] ATA1 : SATA max UDMA/133 irq 88=20
> > [ 1.239639 ] ehci - sunxi 1c14000.ehci0 : EHCI Host Controller=20
> > [ 1.245171 ] ehci - sunxi 1c14000.ehci0 : new USB bus registered ,=20
> assigned bus number 2=20
> > [ 1.252978 ] ehci - sunxi 1c14000.ehci0 : irq 71 , io mem 0x01c14000=20
> > [ 1.269124 ] ehci - sunxi 1c14000.ehci0 : USB 2.0 started , EHCI 1:00=
=20
> > [ 1.275924 ] hub 2-0:1.0 : USB hub found=20
> > [ 1.279773 ] hub 2-0:1.0 : 1 port detected=20
> > [ 1.284455 ] ehci - sunxi 1c1c000.ehci1 : EHCI Host Controller=20
> > [ 1.290026 ] ehci - sunxi 1c1c000.ehci1 : new USB bus registered ,=20
> assigned bus number 3=20
> > [ 1.297789 ] ehci - sunxi 1c1c000.ehci1 : irq 72 , io mem 0x01c1c000=20
> > [ 1.319118 ] ehci - sunxi 1c1c000.ehci1 : USB 2.0 started , EHCI 1:00=
=20
> > [ 1.325805 ] hub 3-0:1.0 : USB hub found=20
> > [ 1.329639 ] hub 3-0:1.0 : 1 port detected=20
> > [ 1.333894 ] rtc - sunxi 1c20d00.rtc : setting system clock to=20
> 1970-01-01 00:00:08 UTC ( 8 )=20
> > [ 1.584180 ] mmc0 : new high speed SDHC card at address E624=20
> > [ 1.590049 ] isa bounce pool size: 16 pages=20
> > [ 1.594297 ] mmcblk0 : mmc0 : E624 SU08G 7:40 GiB=20
> > [ 1.600605 ] mmcblk0 : p1=20
> > [ 4.889135 ] ATA1 : SATA link up 3.0 Gbps ( sstatus 123 SControl 300 )=
=20
> > [ 4.904967 ] ata1.00 : ATA - 8 : SAMSUNG HM320II , 2AC101C4 , max=20
> UDMA/133=20
> > [ 4.911260 ] ata1.00 : 625142448 sectors , multi 0 : LBA48 NCQ (depth=
=20
> 31/32 )=20
> > [ 4.927633 ] ata1.00 : configured for UDMA/133=20
> > [ 4.932311 ] scsi 0:0:0:0 : Direct -Access ATA SAMSUNG HM320II 2AC1 PQ =
:=20
> 0 ANSI : 5=20
> > [ 4.941156 ] sd 0:0:0:0 : [ sda ] 625142448 512 - byte logical blocks :=
=20
> ( 320 GB/298 GiB )=20
> > [ 4.948875 ] sd 0:0:0:0 : [ sda ] Write Protect is off=20
> > [ 4.953822 ] sd 0:0:0:0 : [ sda ] Write cache : enabled , read cache :=
=20
> enabled , does not support DPO or FUA=20
> > [ 4.975349 ] sda : sda1=20
> > [ 4.978721 ] sd 0:0:0:0 : [ sda ] Attached SCSI disk=20
> > [ 5.000798 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with ordered=
=20
> data mode . Opts : ( null)=20
> > [ 5.008962 ] VFS : Mounted root ( ext4 filesystem ) readonly on device=
=20
> 179:1 .=20
> > [ 5.016841 ] devtmpfs : mounted=20
> > [ 5.020432 ] Freeing unused kernel memory: 528k ( c0922000 - c09a6000 )=
=20
> > INIT : version 2.88 booting=20
> >=20
> >=20
> >=20
> > # # # # NOW AFTER UP # # # # # # # # # # #=20
> >=20
> > Even . Config=20
> > git pull=20
> >=20
> >=20
> > [ 1.183099 ] ip6_tables : ( C ) 2000-2006 Netfilter Core Team=20
> > [ 1.188522 ] sit : IPv6 over IPv4 tunneling driver=20
> > [ 1.193777 ] NET : Registered protocol family 17=20
> > [ 1.198369 ] Bridge firewalling registered=20
> > [ 1.202495 ] l2tp_core : L2TP core driver , V2.0=20
> > [ 1.206861 ] 8021Q : 802.1Q VLAN Support v1.8=20
> > [ 1.210139 ] ATA1 : SATA link down ( sstatus 0 SControl 300 )=20
> > [ 1.216491 ] lib80211 : common routines for IEEE802.11 drivers=20
> > [ 1.222231 ] Key type dns_resolver registered=20
> > [ 1.226770 ] Registering SWP / SWPB emulation handler=20
> > [ 1.232696 ] ahci - 5v : 5000 mV=20
> > [ 1.236057 ] usb1 - VBUS : 5000 mV=20
> > [ 1.239504 ] usb2 - VBUS : 5000 mV=20
> > [ 1.243904 ] rtc - sunxi 1c20d00.rtc : setting system clock to=20
> 1970-01-01 00:00:08 UTC ( 8 )=20
> > [ 1.252615 ] Waiting for device / dev/mmcblk0p1 root ...=20
> > [ 1.599045 ] mmc0 : new high speed SDHC card at address E624=20
> > [ 1.604917 ] isa bounce pool size: 16 pages=20
> > [ 1.609178 ] mmcblk0 : mmc0 : E624 SU08G 7:40 GiB=20
> > [ 1.615470 ] mmcblk0 : p1=20
> > [ 1.692426 ] EXT4 - fs ( mmcblk0p1 ) : INFO : recovery required on=20
> readonly filesystem=20
> > [ 1.699757 ] EXT4 - fs ( mmcblk0p1 ) : write access will be enabled=20
> During recovery=20
> > [ 2.423617 ] random: nonblocking pool is initialized=20
> > [ 3.274181 ] EXT4 - fs ( mmcblk0p1 ) : recovery complete=20
> > [ 3.286043 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with ordered=
=20
> data mode . Opts : ( null)=20
> > [ 3.294229 ] VFS : Mounted root ( ext4 filesystem ) readonly on device=
=20
> 179:1 .=20
> > [ 3.302179 ] devtmpfs : mounted=20
> > [ 3.305714 ] Freeing unused kernel memory: 524K ( c0959000 - c09dc000 )=
=20
> > INIT : version 2.88 booting=20
> >=20
> >=20
> > What could it be? says Down !=20
> > Copy your old uImage UP=20
> > new uImage DOWN=20
>
> Which kernel tree are you using ? Did you not only update the uImage but=
=20
> also the dtb? I'm not seeing=20
> any ahci related messages at all in the new dmesg output, so it seems tha=
t=20
> either your dtb does not have=20
> an ahci node (or not with the proper compatible=3D string), or sunxi-ahci=
 is=20
> not build into your kernel.=20
>
> Regards,=20
>
> Hans=20
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_1699_2606243.1390310132875
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>LINUX-SUNXI</div></div><div><div>[core]</div><di=
v><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>reposito=
ryformatversion =3D 0</div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>filemode =3D true</div><div><span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>bare =3D false</div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>logallrefupdates =3D=
 true</div><div>[remote "origin"]</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>fetch =3D +refs/heads/*:refs/remotes/orig=
in/*</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>url =3D https://github.com/jwrdegoede/linux-sunxi.git</div><div>[branc=
h "sunxi-devel"]</div><div><span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>remote =3D origin</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>merge =3D refs/heads/sunxi-devel</div></=
div><div><br></div><div><br></div><div><br></div><div>U-BOOT</div><div><div=
>[core]</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>repositoryformatversion =3D 0</div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span>filemode =3D true</div><div><span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">	</span>bare =3D false</div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>loga=
llrefupdates =3D true</div><div>[remote "origin"]</div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">	</span>fetch =3D +refs/heads/*:r=
efs/remotes/origin/*</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>url =3D https://github.com/jwrdegoede/u-boot-sunxi.git=
</div><div>[branch "sunxi-next"]</div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>remote =3D origin</div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>merge =3D refs/heads/sun=
xi-next</div></div><div><br></div><div><br></div><div>CONFIG_AHCI_SUNXI=3Dy=
</div><div><br></div><div><div>Just took a git pull recompiled the kernel, =
modules and dtb sent MicroSD pro&nbsp;</div><div>and not simply booted the =
Sata UP more ... al had a copy before the git pull recompiled sent to regul=
ar MicroSD he recognizes the HD and do nothing except change the dtb and fo=
rmer Kernek! what could it be?&nbsp;</div><div><br></div><div>Hug!</div></d=
iv><div><br></div><div><br></div><div><div>## Booting kernel from Legacy Im=
age at 46000000 ...</div><div>&nbsp; &nbsp;Image Name: &nbsp; Linux-3.13.0-=
rc7-52420-g41aabcc</div><div>&nbsp; &nbsp;Created: &nbsp; &nbsp; &nbsp;2014=
-01-21 &nbsp;11:58:18 UTC</div><div>&nbsp; &nbsp;Image Type: &nbsp; ARM Lin=
ux Kernel Image (uncompressed)</div><div>&nbsp; &nbsp;Data Size: &nbsp; &nb=
sp;5404880 Bytes =3D 5.2 MiB</div><div>&nbsp; &nbsp;Load Address: 40008000<=
/div><div>&nbsp; &nbsp;Entry Point: &nbsp;40008000</div><div>&nbsp; &nbsp;V=
erifying Checksum ... OK</div><div>## Flattened Device Tree blob at 4900000=
0</div><div>&nbsp; &nbsp;Booting using the fdt blob at 0x49000000</div><div=
>&nbsp; &nbsp;Loading Kernel Image ... OK</div><div>&nbsp; &nbsp;Using Devi=
ce Tree in place at 49000000, end 49007097</div></div><div><br></div><div><=
br></div><br><br><br>Em ter=C3=A7a-feira, 21 de janeiro de 2014 05h58min04s=
 UTC-2, Hans de Goede  escreveu:<blockquote class=3D"gmail_quote" style=3D"=
margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;=
">Hi,
<br>
<br>On 01/20/2014 08:53 PM, Ezaul Zillmer wrote:
<br>&gt; hi Hans
<br>&gt;
<br>&gt; First wanted to thank his work with sunxi ... as they say here in =
Brazil you're the guy !
<br>&gt;
<br>&gt; I noticed the following after your upgrade .. 01/20/2014 my ATA do=
es not look rose more !
<br>&gt; # # # # Here before UP ! # # # # #
<br>&gt;
<br>&gt; Image Name : Linux - 3.13.0 - rc7
<br>&gt;
<br>&gt; [ 1.150317 ] 8021Q : 802.1Q VLAN Support v1.8
<br>&gt; [ 1.154585 ] Key type dns_resolver registered
<br>&gt; [ 1.159130 ] Registering SWP / SWPB emulation handler
<br>&gt; [ 1.165146 ] ahci - 5v : 5000 mV
<br>&gt; [ 1.168509 ] usb1 - VBUS : 5000 mV
<br>&gt; [ 1.172082 ] usb2 - VBUS : 5000 mV
<br>&gt; [ 1.200799 ] ahci sunxi - 1c18000.ahci : controller can not do PMP=
 , turning off CAP_PMP
<br>&gt; [ 1.208303 ] sunxi 1c18000.ahci - ahci : forcing PORTS_IMPL to 0x1
<br>&gt; [ 1.214179 ] sunxi 1c18000.ahci - ahci : AHCI 0001.0100 32 slots 1=
 ports 3 Gbps 0x1 impl sunxi mode
<br>&gt; [ 1.222903 ] sunxi 1c18000.ahci - ahci : flags : NCQ SNTF pm led c=
lo pio slum part ccc only
<br>&gt; [ 1.231594 ] scsi0 : sunxi_ahci
<br>&gt; [ 1.234955 ] ATA1 : SATA max UDMA/133 irq 88
<br>&gt; [ 1.239639 ] ehci - sunxi 1c14000.ehci0 : EHCI Host Controller
<br>&gt; [ 1.245171 ] ehci - sunxi 1c14000.ehci0 : new USB bus registered ,=
 assigned bus number 2
<br>&gt; [ 1.252978 ] ehci - sunxi 1c14000.ehci0 : irq 71 , io mem 0x01c140=
00
<br>&gt; [ 1.269124 ] ehci - sunxi 1c14000.ehci0 : USB 2.0 started , EHCI 1=
:00
<br>&gt; [ 1.275924 ] hub 2-0:1.0 : USB hub found
<br>&gt; [ 1.279773 ] hub 2-0:1.0 : 1 port detected
<br>&gt; [ 1.284455 ] ehci - sunxi 1c1c000.ehci1 : EHCI Host Controller
<br>&gt; [ 1.290026 ] ehci - sunxi 1c1c000.ehci1 : new USB bus registered ,=
 assigned bus number 3
<br>&gt; [ 1.297789 ] ehci - sunxi 1c1c000.ehci1 : irq 72 , io mem 0x01c1c0=
00
<br>&gt; [ 1.319118 ] ehci - sunxi 1c1c000.ehci1 : USB 2.0 started , EHCI 1=
:00
<br>&gt; [ 1.325805 ] hub 3-0:1.0 : USB hub found
<br>&gt; [ 1.329639 ] hub 3-0:1.0 : 1 port detected
<br>&gt; [ 1.333894 ] rtc - sunxi 1c20d00.rtc : setting system clock to 197=
0-01-01 00:00:08 UTC ( 8 )
<br>&gt; [ 1.584180 ] mmc0 : new high speed SDHC card at address E624
<br>&gt; [ 1.590049 ] isa bounce pool size: 16 pages
<br>&gt; [ 1.594297 ] mmcblk0 : mmc0 : E624 SU08G 7:40 GiB
<br>&gt; [ 1.600605 ] mmcblk0 : p1
<br>&gt; [ 4.889135 ] ATA1 : SATA link up 3.0 Gbps ( sstatus 123 SControl 3=
00 )
<br>&gt; [ 4.904967 ] ata1.00 : ATA - 8 : SAMSUNG HM320II , 2AC101C4 , max =
UDMA/133
<br>&gt; [ 4.911260 ] ata1.00 : 625142448 sectors , multi 0 : LBA48 NCQ (de=
pth 31/32 )
<br>&gt; [ 4.927633 ] ata1.00 : configured for UDMA/133
<br>&gt; [ 4.932311 ] scsi 0:0:0:0 : Direct -Access ATA SAMSUNG HM320II 2AC=
1 PQ : 0 ANSI : 5
<br>&gt; [ 4.941156 ] sd 0:0:0:0 : [ sda ] 625142448 512 - byte logical blo=
cks : ( 320 GB/298 GiB )
<br>&gt; [ 4.948875 ] sd 0:0:0:0 : [ sda ] Write Protect is off
<br>&gt; [ 4.953822 ] sd 0:0:0:0 : [ sda ] Write cache : enabled , read cac=
he : enabled , does not support DPO or FUA
<br>&gt; [ 4.975349 ] sda : sda1
<br>&gt; [ 4.978721 ] sd 0:0:0:0 : [ sda ] Attached SCSI disk
<br>&gt; [ 5.000798 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with ord=
ered data mode . Opts : ( null)
<br>&gt; [ 5.008962 ] VFS : Mounted root ( ext4 filesystem ) readonly on de=
vice 179:1 .
<br>&gt; [ 5.016841 ] devtmpfs : mounted
<br>&gt; [ 5.020432 ] Freeing unused kernel memory: 528k ( c0922000 - c09a6=
000 )
<br>&gt; INIT : version 2.88 booting
<br>&gt;
<br>&gt;
<br>&gt;
<br>&gt; # # # # NOW AFTER UP # # # # # # # # # # #
<br>&gt;
<br>&gt; Even . Config
<br>&gt; git pull
<br>&gt;
<br>&gt;
<br>&gt; [ 1.183099 ] ip6_tables : ( C ) 2000-2006 Netfilter Core Team
<br>&gt; [ 1.188522 ] sit : IPv6 over IPv4 tunneling driver
<br>&gt; [ 1.193777 ] NET : Registered protocol family 17
<br>&gt; [ 1.198369 ] Bridge firewalling registered
<br>&gt; [ 1.202495 ] l2tp_core : L2TP core driver , V2.0
<br>&gt; [ 1.206861 ] 8021Q : 802.1Q VLAN Support v1.8
<br>&gt; [ 1.210139 ] ATA1 : SATA link down ( sstatus 0 SControl 300 )
<br>&gt; [ 1.216491 ] lib80211 : common routines for IEEE802.11 drivers
<br>&gt; [ 1.222231 ] Key type dns_resolver registered
<br>&gt; [ 1.226770 ] Registering SWP / SWPB emulation handler
<br>&gt; [ 1.232696 ] ahci - 5v : 5000 mV
<br>&gt; [ 1.236057 ] usb1 - VBUS : 5000 mV
<br>&gt; [ 1.239504 ] usb2 - VBUS : 5000 mV
<br>&gt; [ 1.243904 ] rtc - sunxi 1c20d00.rtc : setting system clock to 197=
0-01-01 00:00:08 UTC ( 8 )
<br>&gt; [ 1.252615 ] Waiting for device / dev/mmcblk0p1 root ...
<br>&gt; [ 1.599045 ] mmc0 : new high speed SDHC card at address E624
<br>&gt; [ 1.604917 ] isa bounce pool size: 16 pages
<br>&gt; [ 1.609178 ] mmcblk0 : mmc0 : E624 SU08G 7:40 GiB
<br>&gt; [ 1.615470 ] mmcblk0 : p1
<br>&gt; [ 1.692426 ] EXT4 - fs ( mmcblk0p1 ) : INFO : recovery required on=
 readonly filesystem
<br>&gt; [ 1.699757 ] EXT4 - fs ( mmcblk0p1 ) : write access will be enable=
d During recovery
<br>&gt; [ 2.423617 ] random: nonblocking pool is initialized
<br>&gt; [ 3.274181 ] EXT4 - fs ( mmcblk0p1 ) : recovery complete
<br>&gt; [ 3.286043 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with ord=
ered data mode . Opts : ( null)
<br>&gt; [ 3.294229 ] VFS : Mounted root ( ext4 filesystem ) readonly on de=
vice 179:1 .
<br>&gt; [ 3.302179 ] devtmpfs : mounted
<br>&gt; [ 3.305714 ] Freeing unused kernel memory: 524K ( c0959000 - c09dc=
000 )
<br>&gt; INIT : version 2.88 booting
<br>&gt;
<br>&gt;
<br>&gt; What could it be? says Down !
<br>&gt; Copy your old uImage UP
<br>&gt; new uImage DOWN
<br>
<br>Which kernel tree are you using ? Did you not only update the uImage bu=
t also the dtb? I'm not seeing
<br>any ahci related messages at all in the new dmesg output, so it seems t=
hat either your dtb does not have
<br>an ahci node (or not with the proper compatible=3D string), or sunxi-ah=
ci is not build into your kernel.
<br>
<br>Regards,
<br>
<br>Hans
<br></blockquote></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_1699_2606243.1390310132875--
