From: Tim Small <tim@buttersideup.com>
Subject: SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Fri, 05 Feb 2010 14:07:49 +0000
Message-ID: <4B6C2635.105@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <smartmontools-support-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=smartmontools-support>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
Errors-To: smartmontools-support-bounces@lists.sourceforge.net
To: "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

I have a couple of Debian Lenny ("2.6.26-2-amd64") boxes on rented 
hardware, each has a couple of SATA drives:

One has 2x 1TB Seagate Barracuda 7200.11 model ST31000333AS firmware SD35

The other has 2x 2TB WD Caviar Green model WDC WD20EADS-00R6B0 firmware 
01.00A01

... the machines are currently set up to run smartd, and also log HDD 
temp via munin.  ata_piix is the driver in use.

The WD machine did this sort of thing a couple of times, which got my 
attention.

[119061.717865] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[119061.717865] ata1.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[119061.717865] ata1.00: status: { DRDY }
[119071.117368] ata1: link is slow to respond, please be patient (ready=0)
[119079.800059] ata1: device not ready (errno=-16), forcing hardreset
[119079.800091] ata1: soft resetting link
[119087.950128] ata1: link is slow to respond, please be patient (ready=0)
[119097.895803] ata1: SRST failed (errno=-16)
[119097.895881] ata1: soft resetting link
[119107.170874] ata1: link is slow to respond, please be patient (ready=0)
[119114.902193] ata1: SRST failed (errno=-16)
[119114.902219] ata1: soft resetting link
[119123.749111] ata1: link is slow to respond, please be patient (ready=0)
[119176.735727] ata1: SRST failed (errno=-16)
[119176.735761] ata1: soft resetting link
[119185.513569] ata1: SRST failed (errno=-16)
[119185.513593] ata1: reset failed, giving up
[119185.513622] ata1.00: disabled
[119185.513643] ata1.01: disabled
[119185.513680] end_request: I/O error, dev sda, sector 39069887
[119185.516684] ata1: EH complete
[119186.013456] sd 0:0:0:0: [sda]
Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[119186.013456] end_request: I/O error, dev sda, sector 36525807


If I run a continuous "dd of=file ; sync ; rm file ; sync" to a file on 
the RAID1 mirror of both drives, at the same time as run a continous 
"smartctl -s on -a /dev/sdX > /dev/null || echo failed", then:

1. The smartctl command fails about once in 20 times, and I get a lot of 
this happening:

[93058.989603] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen     
[93058.989645] ata1.01: cmd 35/00:00:a4:f2:51/00:04:03:00:00/f0 tag 0 
dma 524288 out
[93058.993582] ata1.01: status: { DRDY 
}                                            
[93058.993582] ata1: soft resetting 
link                                            
                                                                                     

[93090.804353] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen     
[93090.804395] ata1.01: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/10 tag 0 
pio 512 in    
[93090.804427] ata1.01: status: { DRDY 
}                                            
[93090.804458] ata1: soft resetting 
link                                            
                                                                                     

[93252.493902] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen     
[93252.493913] ata1.01: cmd c8/00:80:4c:d0:83/00:00:00:00:00/fa tag 0 
dma 65536 in  
[93252.493913] ata1.01: status: { DRDY 
}                                            
[93252.493913] ata1: soft resetting 
link                                            
                                                                                     

[96265.917847] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen     
[96265.917889] ata1.01: cmd c8/00:80:4c:2c:c1/00:00:00:00:00/fa tag 0 
dma 65536 in  
[96265.921800] ata1.01: status: { DRDY 
}                                            
[96265.921800] ata1: soft resetting 
link                                            
                                                                                     

[96405.491834] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen     
[96405.491834] ata1.01: cmd 25/00:00:cc:a6:c3/00:04:0a:00:00/f0 tag 0 
dma 524288 in 
[96405.491834] ata1.01: status: { DRDY 
}                                            
[96413.900149] ata1: link is slow to respond, please be patient 
(ready=0)           
                                                                                     

[99772.901861] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen     
[99772.901861] ata1.01: cmd ca/00:08:cc:d3:54/00:00:00:00:00/f3 tag 0 
dma 4096 out  
[99772.901861] ata1.01: status: { DRDY 
}                                            
[99783.604235] ata1: link is slow to respond, please be patient 
(ready=0)           
                                                                                     

[100012.860158] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen    
[100012.860201] ata1.01: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/10 tag 0 
pio 512 in
[100012.860247] ata1.01: status: { DRDY }
[100012.860281] ata1: soft resetting link

[100256.314912] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[100256.314950] ata1.01: cmd c8/00:80:cc:12:13/00:00:00:00:00/fb tag 0 
dma 65536 in
[100256.314997] ata1.01: status: { DRDY }
[100256.315025] ata1: soft resetting link

[101528.503318] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[101528.503318] ata1.01: cmd c8/00:00:4c:c4:2c/00:00:00:00:00/fb tag 0 
dma 131072 in
[101528.503318] ata1.01: status: { DRDY }
[101535.883662] ata1: link is slow to respond, please be patient (ready=0)

[107747.382563] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[107747.382605] ata1.01: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/10 tag 0 
pio 512 in
[107747.386545] ata1.01: status: { DRDY }
[107747.386545] ata1: soft resetting link

[107918.831736] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[107918.831736] ata1.01: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/10 tag 0 
pio 512 in
[107918.831736] ata1.01: status: { DRDY }
[107918.831736] ata1: soft resetting link


Sometimes the "resetting link" happens a few times, and if it happens 
enough times, then ata_piix gives up and disables BOTH drives (like the 
first time), which is a bit annoying - this reset-fails behaviour 
normally seems to happen when the drives are not doing much (i.e. in 
normal operation rather than under-test).

If I disable smart data collection (smartd and munin), then the errors 
seem to stop - which I can do obviously, but would prefer not to.

smartctl -x reports the following interesting-looking stuff on the 
device which I've been stressing with smartctl:

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
...
0x000a  2            5  Device-to-host register FISes sent due to a COMRESET
0x8000  4        79322  Vendor specific

and this on the one where I haven't:

0x000a  2            2  Device-to-host register FISes sent due to a COMRESET
0x8000  4         6779  Vendor specific



... so I would suspect that this is a bug in the WD drives, except that 
the same thing seems to occasionally happen on the machine with the 
Seagate drives:

[1718254.879156] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[1718254.879211] ata1.00: cmd c8/00:08:3c:f1:bf/00:00:00:00:00/e9 tag 0 
dma 4096 in
[1718254.879213]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[1718254.879316] ata1.00: status: { DRDY }
[1718262.237404] ata1: link is slow to respond, please be patient (ready=0)
[1718270.057698] ata1: device not ready (errno=-16), forcing hardreset
[1718270.057732] ata1: soft resetting link
[1718277.841779] ata1: link is slow to respond, please be patient (ready=0)
[1718281.134473] ata1.00: configured for UDMA/133
[1718281.192815] ata1.01: configured for UDMA/133
[1718281.192815] ata1: EH complete

[1729049.865692] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[1729049.865692] ata1.00: cmd c8/00:08:dc:b3:bf/00:00:00:00:00/e9 tag 0 
dma 4096 in
[1729049.865692]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[1729049.865692] ata1.00: status: { DRDY }
[1729059.627313] ata1: link is slow to respond, please be patient (ready=0)
[1729068.499782] ata1: device not ready (errno=-16), forcing hardreset
[1729068.499823] ata1: soft resetting link
[1729078.434813] ata1: link is slow to respond, please be patient (ready=0)
[1729088.807850] ata1: SRST failed (errno=-16)
[1729088.807881] ata1: soft resetting link
[1729089.582856] ata1.00: configured for UDMA/133


with this on the stressed drive:

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x000a  2           10  Device-to-host register FISes sent due to a COMRESET


and this on the non-stressed drive:

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x000a  2            1  Device-to-host register FISes sent due to a COMRESET


I'd be happy to put a newer kernel on one or both machines to see if 
that'd have any effect.  I also tried doing "hdparm -I" instead of 
"smartctl -a" for a few hours but that didn't elicit any "frozen" 
messages (although I should probably run it for a bit longer to have 
more confidence in that statement).

So, err I suppose that this could be a bug in:

. smartctl
. both HD firmwares
. ata_piix (certainly disabling both drives seems a bit drastic, but I 
don't know if this is a function of the hardware)
. the ICH7 hardware

unfortunately as I don't own the hardware, I'm not in a position to get 
a different SATA controller in the boxes to eliminate the last two.

Any ideas welcome....

Cheers,

Tim.

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
