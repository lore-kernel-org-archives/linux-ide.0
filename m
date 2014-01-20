From: Ezaul Zillmer <ezaulzillmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC v4 00/10] ahci: library-ise
 ahci_platform, add sunxi driver and cleanup imx driver
Date: Mon, 20 Jan 2014 11:53:34 -0800 (PST)
Message-ID: <b8dd9fd4-02ce-4656-8b92-49f2ab82cc69@googlegroups.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1884_25575744.1390247614595"
Return-path: <linux-sunxi+bncBD2ILSOUX4CBBP756WLAKGQEGCLNTWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390236303-22538-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

------=_Part_1884_25575744.1390247614595
Content-Type: text/plain; charset=UTF-8

hi Hans

First wanted to thank his work with sunxi ... as they say here in Brazil 
you're the guy !

I noticed the following after your upgrade .. 01/20/2014 my ATA does not 
look rose more !
# # # # Here before UP ! # # # # #

Image Name : Linux - 3.13.0 - rc7

[ 1.150317 ] 8021Q : 802.1Q VLAN Support v1.8
[ 1.154585 ] Key type dns_resolver registered
[ 1.159130 ] Registering SWP / SWPB emulation handler
[ 1.165146 ] ahci - 5v : 5000 mV
[ 1.168509 ] usb1 - VBUS : 5000 mV
[ 1.172082 ] usb2 - VBUS : 5000 mV
[ 1.200799 ] ahci sunxi - 1c18000.ahci : controller can not do PMP , 
turning off CAP_PMP
[ 1.208303 ] sunxi 1c18000.ahci - ahci : forcing PORTS_IMPL to 0x1
[ 1.214179 ] sunxi 1c18000.ahci - ahci : AHCI 0001.0100 32 slots 1 ports 3 
Gbps 0x1 impl sunxi mode
[ 1.222903 ] sunxi 1c18000.ahci - ahci : flags : NCQ SNTF pm led clo pio 
slum part ccc only
[ 1.231594 ] scsi0 : sunxi_ahci
[ 1.234955 ] ATA1 : SATA max UDMA/133 irq 88
[ 1.239639 ] ehci - sunxi 1c14000.ehci0 : EHCI Host Controller
[ 1.245171 ] ehci - sunxi 1c14000.ehci0 : new USB bus registered , assigned 
bus number 2
[ 1.252978 ] ehci - sunxi 1c14000.ehci0 : irq 71 , io mem 0x01c14000
[ 1.269124 ] ehci - sunxi 1c14000.ehci0 : USB 2.0 started , EHCI 1:00
[ 1.275924 ] hub 2-0:1.0 : USB hub found
[ 1.279773 ] hub 2-0:1.0 : 1 port detected
[ 1.284455 ] ehci - sunxi 1c1c000.ehci1 : EHCI Host Controller
[ 1.290026 ] ehci - sunxi 1c1c000.ehci1 : new USB bus registered , assigned 
bus number 3
[ 1.297789 ] ehci - sunxi 1c1c000.ehci1 : irq 72 , io mem 0x01c1c000
[ 1.319118 ] ehci - sunxi 1c1c000.ehci1 : USB 2.0 started , EHCI 1:00
[ 1.325805 ] hub 3-0:1.0 : USB hub found
[ 1.329639 ] hub 3-0:1.0 : 1 port detected
[ 1.333894 ] rtc - sunxi 1c20d00.rtc : setting system clock to 1970-01-01 
00:00:08 UTC ( 8 )
[ 1.584180 ] mmc0 : new high speed SDHC card at address E624
[ 1.590049 ] isa bounce pool size: 16 pages
[ 1.594297 ] mmcblk0 : mmc0 : E624 SU08G 7:40 GiB
[ 1.600605 ] mmcblk0 : p1
[ 4.889135 ] ATA1 : SATA link up 3.0 Gbps ( sstatus 123 SControl 300 )
[ 4.904967 ] ata1.00 : ATA - 8 : SAMSUNG HM320II , 2AC101C4 , max UDMA/133
[ 4.911260 ] ata1.00 : 625142448 sectors , multi 0 : LBA48 NCQ (depth 31/32 
)
[ 4.927633 ] ata1.00 : configured for UDMA/133
[ 4.932311 ] scsi 0:0:0:0 : Direct -Access ATA SAMSUNG HM320II 2AC1 PQ : 0 
ANSI : 5
[ 4.941156 ] sd 0:0:0:0 : [ sda ] 625142448 512 - byte logical blocks : ( 
320 GB/298 GiB )
[ 4.948875 ] sd 0:0:0:0 : [ sda ] Write Protect is off
[ 4.953822 ] sd 0:0:0:0 : [ sda ] Write cache : enabled , read cache : 
enabled , does not support DPO or FUA
[ 4.975349 ] sda : sda1
[ 4.978721 ] sd 0:0:0:0 : [ sda ] Attached SCSI disk
[ 5.000798 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with ordered data 
mode . Opts : ( null)
[ 5.008962 ] VFS : Mounted root ( ext4 filesystem ) readonly on device 
179:1 .
[ 5.016841 ] devtmpfs : mounted
[ 5.020432 ] Freeing unused kernel memory: 528k ( c0922000 - c09a6000 )
INIT : version 2.88 booting



# # # # NOW AFTER UP # # # # # # # # # # #

Even . Config
git pull


[ 1.183099 ] ip6_tables : ( C ) 2000-2006 Netfilter Core Team
[ 1.188522 ] sit : IPv6 over IPv4 tunneling driver
[ 1.193777 ] NET : Registered protocol family 17
[ 1.198369 ] Bridge firewalling registered
[ 1.202495 ] l2tp_core : L2TP core driver , V2.0
[ 1.206861 ] 8021Q : 802.1Q VLAN Support v1.8
[ 1.210139 ] ATA1 : SATA link down ( sstatus 0 SControl 300 )
[ 1.216491 ] lib80211 : common routines for IEEE802.11 drivers
[ 1.222231 ] Key type dns_resolver registered
[ 1.226770 ] Registering SWP / SWPB emulation handler
[ 1.232696 ] ahci - 5v : 5000 mV
[ 1.236057 ] usb1 - VBUS : 5000 mV
[ 1.239504 ] usb2 - VBUS : 5000 mV
[ 1.243904 ] rtc - sunxi 1c20d00.rtc : setting system clock to 1970-01-01 
00:00:08 UTC ( 8 )
[ 1.252615 ] Waiting for device / dev/mmcblk0p1 root ...
[ 1.599045 ] mmc0 : new high speed SDHC card at address E624
[ 1.604917 ] isa bounce pool size: 16 pages
[ 1.609178 ] mmcblk0 : mmc0 : E624 SU08G 7:40 GiB
[ 1.615470 ] mmcblk0 : p1
[ 1.692426 ] EXT4 - fs ( mmcblk0p1 ) : INFO : recovery required on readonly 
filesystem
[ 1.699757 ] EXT4 - fs ( mmcblk0p1 ) : write access will be enabled During 
recovery
[ 2.423617 ] random: nonblocking pool is initialized
[ 3.274181 ] EXT4 - fs ( mmcblk0p1 ) : recovery complete
[ 3.286043 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with ordered data 
mode . Opts : ( null)
[ 3.294229 ] VFS : Mounted root ( ext4 filesystem ) readonly on device 
179:1 .
[ 3.302179 ] devtmpfs : mounted
[ 3.305714 ] Freeing unused kernel memory: 524K ( c0959000 - c09dc000 )
INIT : version 2.88 booting


What could it be? says Down !
Copy your old uImage UP
new uImage DOWN 

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_1884_25575744.1390247614595
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi Hans<div><div><br></div><div>First wanted to thank his =
work with sunxi ... as they say here in Brazil you're the guy !</div><div><=
br></div><div>I noticed the following after your upgrade .. 01/20/2014 my A=
TA does not look rose more !</div><div># # # # Here before UP ! # # # # #</=
div><div><br></div><div>Image Name : Linux - 3.13.0 - rc7</div><div><br></d=
iv><div>[ 1.150317 ] 8021Q : 802.1Q VLAN Support v1.8</div><div>[ 1.154585 =
] Key type dns_resolver registered</div><div>[ 1.159130 ] Registering SWP /=
 SWPB emulation handler</div><div>[ 1.165146 ] ahci - 5v : 5000 mV</div><di=
v>[ 1.168509 ] usb1 - VBUS : 5000 mV</div><div>[ 1.172082 ] usb2 - VBUS : 5=
000 mV</div><div>[ 1.200799 ] ahci sunxi - 1c18000.ahci : controller can no=
t do PMP , turning off CAP_PMP</div><div>[ 1.208303 ] sunxi 1c18000.ahci - =
ahci : forcing PORTS_IMPL to 0x1</div><div>[ 1.214179 ] sunxi 1c18000.ahci =
- ahci : AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl sunxi mode</div><d=
iv>[ 1.222903 ] sunxi 1c18000.ahci - ahci : flags : NCQ SNTF pm led clo pio=
 slum part ccc only</div><div>[ 1.231594 ] scsi0 : sunxi_ahci</div><div>[ 1=
.234955 ] ATA1 : SATA max UDMA/133 irq 88</div><div>[ 1.239639 ] ehci - sun=
xi 1c14000.ehci0 : EHCI Host Controller</div><div>[ 1.245171 ] ehci - sunxi=
 1c14000.ehci0 : new USB bus registered , assigned bus number 2</div><div>[=
 1.252978 ] ehci - sunxi 1c14000.ehci0 : irq 71 , io mem 0x01c14000</div><d=
iv>[ 1.269124 ] ehci - sunxi 1c14000.ehci0 : USB 2.0 started , EHCI 1:00</d=
iv><div>[ 1.275924 ] hub 2-0:1.0 : USB hub found</div><div>[ 1.279773 ] hub=
 2-0:1.0 : 1 port detected</div><div>[ 1.284455 ] ehci - sunxi 1c1c000.ehci=
1 : EHCI Host Controller</div><div>[ 1.290026 ] ehci - sunxi 1c1c000.ehci1 =
: new USB bus registered , assigned bus number 3</div><div>[ 1.297789 ] ehc=
i - sunxi 1c1c000.ehci1 : irq 72 , io mem 0x01c1c000</div><div>[ 1.319118 ]=
 ehci - sunxi 1c1c000.ehci1 : USB 2.0 started , EHCI 1:00</div><div>[ 1.325=
805 ] hub 3-0:1.0 : USB hub found</div><div>[ 1.329639 ] hub 3-0:1.0 : 1 po=
rt detected</div><div>[ 1.333894 ] rtc - sunxi 1c20d00.rtc : setting system=
 clock to 1970-01-01 00:00:08 UTC ( 8 )</div><div>[ 1.584180 ] mmc0 : new h=
igh speed SDHC card at address E624</div><div>[ 1.590049 ] isa bounce pool =
size: 16 pages</div><div>[ 1.594297 ] mmcblk0 : mmc0 : E624 SU08G 7:40 GiB<=
/div><div>[ 1.600605 ] mmcblk0 : p1</div><div>[ 4.889135 ] ATA1 : SATA link=
 up 3.0 Gbps ( sstatus 123 SControl 300 )</div><div>[ 4.904967 ] ata1.00 : =
ATA - 8 : SAMSUNG HM320II , 2AC101C4 , max UDMA/133</div><div>[ 4.911260 ] =
ata1.00 : 625142448 sectors , multi 0 : LBA48 NCQ (depth 31/32 )</div><div>=
[ 4.927633 ] ata1.00 : configured for UDMA/133</div><div>[ 4.932311 ] scsi =
0:0:0:0 : Direct -Access ATA SAMSUNG HM320II 2AC1 PQ : 0 ANSI : 5</div><div=
>[ 4.941156 ] sd 0:0:0:0 : [ sda ] 625142448 512 - byte logical blocks : ( =
320 GB/298 GiB )</div><div>[ 4.948875 ] sd 0:0:0:0 : [ sda ] Write Protect =
is off</div><div>[ 4.953822 ] sd 0:0:0:0 : [ sda ] Write cache : enabled , =
read cache : enabled , does not support DPO or FUA</div><div>[ 4.975349 ] s=
da : sda1</div><div>[ 4.978721 ] sd 0:0:0:0 : [ sda ] Attached SCSI disk</d=
iv><div>[ 5.000798 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with orde=
red data mode . Opts : ( null)</div><div>[ 5.008962 ] VFS : Mounted root ( =
ext4 filesystem ) readonly on device 179:1 .</div><div>[ 5.016841 ] devtmpf=
s : mounted</div><div>[ 5.020432 ] Freeing unused kernel memory: 528k ( c09=
22000 - c09a6000 )</div><div>INIT : version 2.88 booting</div><div><br></di=
v><div><br></div><div><br></div><div># # # # NOW AFTER UP # # # # # # # # #=
 # #</div><div><br></div><div>Even . Config</div><div>git pull</div><div><b=
r></div><div><br></div><div>[ 1.183099 ] ip6_tables : ( C ) 2000-2006 Netfi=
lter Core Team</div><div>[ 1.188522 ] sit : IPv6 over IPv4 tunneling driver=
</div><div>[ 1.193777 ] NET : Registered protocol family 17</div><div>[ 1.1=
98369 ] Bridge firewalling registered</div><div>[ 1.202495 ] l2tp_core : L2=
TP core driver , V2.0</div><div>[ 1.206861 ] 8021Q : 802.1Q VLAN Support v1=
.8</div><div>[ 1.210139 ] ATA1 : SATA link down ( sstatus 0 SControl 300 )<=
/div><div>[ 1.216491 ] lib80211 : common routines for IEEE802.11 drivers</d=
iv><div>[ 1.222231 ] Key type dns_resolver registered</div><div>[ 1.226770 =
] Registering SWP / SWPB emulation handler</div><div>[ 1.232696 ] ahci - 5v=
 : 5000 mV</div><div>[ 1.236057 ] usb1 - VBUS : 5000 mV</div><div>[ 1.23950=
4 ] usb2 - VBUS : 5000 mV</div><div>[ 1.243904 ] rtc - sunxi 1c20d00.rtc : =
setting system clock to 1970-01-01 00:00:08 UTC ( 8 )</div><div>[ 1.252615 =
] Waiting for device / dev/mmcblk0p1 root ...</div><div>[ 1.599045 ] mmc0 :=
 new high speed SDHC card at address E624</div><div>[ 1.604917 ] isa bounce=
 pool size: 16 pages</div><div>[ 1.609178 ] mmcblk0 : mmc0 : E624 SU08G 7:4=
0 GiB</div><div>[ 1.615470 ] mmcblk0 : p1</div><div>[ 1.692426 ] EXT4 - fs =
( mmcblk0p1 ) : INFO : recovery required on readonly filesystem</div><div>[=
 1.699757 ] EXT4 - fs ( mmcblk0p1 ) : write access will be enabled During r=
ecovery</div><div>[ 2.423617 ] random: nonblocking pool is initialized</div=
><div>[ 3.274181 ] EXT4 - fs ( mmcblk0p1 ) : recovery complete</div><div>[ =
3.286043 ] EXT4 - fs ( mmcblk0p1 ) : mounted filesystem with ordered data m=
ode . Opts : ( null)</div><div>[ 3.294229 ] VFS : Mounted root ( ext4 files=
ystem ) readonly on device 179:1 .</div><div>[ 3.302179 ] devtmpfs : mounte=
d</div><div>[ 3.305714 ] Freeing unused kernel memory: 524K ( c0959000 - c0=
9dc000 )</div><div>INIT : version 2.88 booting</div><div><br></div><div><br=
></div><div>What could it be? says Down !</div><div>Copy your old uImage UP=
</div><div>new uImage DOWN&nbsp;</div></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_1884_25575744.1390247614595--
