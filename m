From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: Serious IDE problem still present in 2.6.14
Date: Mon, 31 Oct 2005 14:02:24 -0500
Message-ID: <1130785344.5932.6.camel@montroll.chem.mcgill.ca>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>
	 <1130689871.6348.3.camel@montroll.chem.mcgill.ca>
	 <4365511C.7040903@yahoo.de>
	 <1130713716.6348.7.camel@montroll.chem.mcgill.ca>
	 <4365596F.4060105@yahoo.de>
Reply-To: David.Ronis@mcgill.ca
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from torrent.cc.mcgill.ca ([132.206.27.49]:45709 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S932164AbVJaTDI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2005 14:03:08 -0500
In-Reply-To: <4365596F.4060105@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: David.Ronis@mcgill.ca, Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org

Hi Stefan,

I tried removing the modules you suggested and reran hdparm -tT /dev/hda
after each.  No difference.  I also played a bit more by going to
single-user mode and killing off various things (like udevd).   I turned
off networking and removed the ethernet driver--still no change.  What
seemed to make a difference was to turn of the firewall and remove all
the ipt_ drivers, although the performance was still about 4 times less
than what I get with the 2.6.13.6 kernel.  

Anyhow here are the results for the modules you asked about:

David
removing module yenta_socket

Module                  Size  Used by
autofs4                19972  1 
snd_pcm_oss            53664  0 
snd_mixer_oss          19328  1 snd_pcm_oss
nfsd                  227680  8 
exportfs                6528  1 nfsd
lockd                  62728  2 nfsd
sunrpc                144828  2 nfsd,lockd
ipt_limit               2688  1 
ipt_LOG                 7296  2 
ipt_state               2176  4 
ip_conntrack           49244  1 ipt_state
iptable_filter          3200  1 
ip_tables              21504  4
ipt_limit,ipt_LOG,ipt_state,iptable_filter
uhci_hcd               33296  0 
ati_agp                 9100  1 
snd_atiixp             21600  0 
snd_ac97_codec         94716  1 snd_atiixp
snd_ac97_bus            2432  1 snd_ac97_codec
snd_pcm                90884  3 snd_pcm_oss,snd_atiixp,snd_ac97_codec
snd_timer              25604  1 snd_pcm
snd                    56164  6
snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         11016  2 snd_atiixp,snd_pcm
8250_pci               19712  0 
eth1394                21128  0 
8250                   25076  1 8250_pci
serial_core            22016  1 8250
ohci1394               36276  0 
ieee1394               99896  2 eth1394,ohci1394
usbhid                 31236  0 
ohci_hcd               21892  0 
ehci_hcd               35592  0 
usbcore               121728  5 uhci_hcd,usbhid,ohci_hcd,ehci_hcd
8139too                27008  0 
mii                     5632  1 8139too
crc32                   4608  1 8139too
agpgart                35020  1 ati_agp


/dev/hda:
 Timing cached reads:    76 MB in  2.32 seconds =  32.78 MB/sec
 Timing buffered disk reads:   18 MB in  3.12 seconds =   5.76 MB/sec
removing module usbhid

Module                  Size  Used by
autofs4                19972  1 
snd_pcm_oss            53664  0 
snd_mixer_oss          19328  1 snd_pcm_oss
nfsd                  227680  8 
exportfs                6528  1 nfsd
lockd                  62728  2 nfsd
sunrpc                144828  2 nfsd,lockd
ipt_limit               2688  1 
ipt_LOG                 7296  2 
ipt_state               2176  4 
ip_conntrack           49244  1 ipt_state
iptable_filter          3200  1 
ip_tables              21504  4
ipt_limit,ipt_LOG,ipt_state,iptable_filter
uhci_hcd               33296  0 
ati_agp                 9100  1 
snd_atiixp             21600  0 
snd_ac97_codec         94716  1 snd_atiixp
snd_ac97_bus            2432  1 snd_ac97_codec
snd_pcm                90884  3 snd_pcm_oss,snd_atiixp,snd_ac97_codec
snd_timer              25604  1 snd_pcm
snd                    56164  6
snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         11016  2 snd_atiixp,snd_pcm
8250_pci               19712  0 
eth1394                21128  0 
8250                   25076  1 8250_pci
serial_core            22016  1 8250
ohci1394               36276  0 
ieee1394               99896  2 eth1394,ohci1394
ohci_hcd               21892  0 
ehci_hcd               35592  0 
usbcore               121728  4 uhci_hcd,ohci_hcd,ehci_hcd
8139too                27008  0 
mii                     5632  1 8139too
crc32                   4608  1 8139too
agpgart                35020  1 ati_agp


/dev/hda:
 Timing cached reads:    24 MB in  2.10 seconds =  11.41 MB/sec
 Timing buffered disk reads:   40 MB in  3.06 seconds =  13.07 MB/sec
removing module ohci_hcd

Module                  Size  Used by
autofs4                19972  1 
snd_pcm_oss            53664  0 
snd_mixer_oss          19328  1 snd_pcm_oss
nfsd                  227680  8 
exportfs                6528  1 nfsd
lockd                  62728  2 nfsd
sunrpc                144828  2 nfsd,lockd
ipt_limit               2688  1 
ipt_LOG                 7296  2 
ipt_state               2176  4 
ip_conntrack           49244  1 ipt_state
iptable_filter          3200  1 
ip_tables              21504  4
ipt_limit,ipt_LOG,ipt_state,iptable_filter
uhci_hcd               33296  0 
ati_agp                 9100  1 
snd_atiixp             21600  0 
snd_ac97_codec         94716  1 snd_atiixp
snd_ac97_bus            2432  1 snd_ac97_codec
snd_pcm                90884  3 snd_pcm_oss,snd_atiixp,snd_ac97_codec
snd_timer              25604  1 snd_pcm
snd                    56164  6
snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         11016  2 snd_atiixp,snd_pcm
8250_pci               19712  0 
eth1394                21128  0 
8250                   25076  1 8250_pci
serial_core            22016  1 8250
ohci1394               36276  0 
ieee1394               99896  2 eth1394,ohci1394
ehci_hcd               35592  0 
usbcore               121728  3 uhci_hcd,ehci_hcd
8139too                27008  0 
mii                     5632  1 8139too
crc32                   4608  1 8139too
agpgart                35020  1 ati_agp


/dev/hda:
 Timing cached reads:    28 MB in  2.13 seconds =  13.14 MB/sec
 Timing buffered disk reads:   30 MB in  3.02 seconds =   9.95 MB/sec
removing module ehci_hcd

Module                  Size  Used by
autofs4                19972  1 
snd_pcm_oss            53664  0 
snd_mixer_oss          19328  1 snd_pcm_oss
nfsd                  227680  8 
exportfs                6528  1 nfsd
lockd                  62728  2 nfsd
sunrpc                144828  2 nfsd,lockd
ipt_limit               2688  1 
ipt_LOG                 7296  2 
ipt_state               2176  4 
ip_conntrack           49244  1 ipt_state
iptable_filter          3200  1 
ip_tables              21504  4
ipt_limit,ipt_LOG,ipt_state,iptable_filter
uhci_hcd               33296  0 
ati_agp                 9100  1 
snd_atiixp             21600  0 
snd_ac97_codec         94716  1 snd_atiixp
snd_ac97_bus            2432  1 snd_ac97_codec
snd_pcm                90884  3 snd_pcm_oss,snd_atiixp,snd_ac97_codec
snd_timer              25604  1 snd_pcm
snd                    56164  6
snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         11016  2 snd_atiixp,snd_pcm
8250_pci               19712  0 
eth1394                21128  0 
8250                   25076  1 8250_pci
serial_core            22016  1 8250
ohci1394               36276  0 
ieee1394               99896  2 eth1394,ohci1394
usbcore               121728  2 uhci_hcd
8139too                27008  0 
mii                     5632  1 8139too
crc32                   4608  1 8139too
agpgart                35020  1 ati_agp


/dev/hda:
 Timing cached reads:    28 MB in  2.04 seconds =  13.75 MB/sec
 Timing buffered disk reads:   20 MB in  3.26 seconds =   6.14 MB/sec
removing module uhci_hcd

Module                  Size  Used by
autofs4                19972  1 
snd_pcm_oss            53664  0 
snd_mixer_oss          19328  1 snd_pcm_oss
nfsd                  227680  8 
exportfs                6528  1 nfsd
lockd                  62728  2 nfsd
sunrpc                144828  2 nfsd,lockd
ipt_limit               2688  1 
ipt_LOG                 7296  2 
ipt_state               2176  4 
ip_conntrack           49244  1 ipt_state
iptable_filter          3200  1 
ip_tables              21504  4
ipt_limit,ipt_LOG,ipt_state,iptable_filter
ati_agp                 9100  1 
snd_atiixp             21600  0 
snd_ac97_codec         94716  1 snd_atiixp
snd_ac97_bus            2432  1 snd_ac97_codec
snd_pcm                90884  3 snd_pcm_oss,snd_atiixp,snd_ac97_codec
snd_timer              25604  1 snd_pcm
snd                    56164  6
snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         11016  2 snd_atiixp,snd_pcm
8250_pci               19712  0 
eth1394                21128  0 
8250                   25076  1 8250_pci
serial_core            22016  1 8250
ohci1394               36276  0 
ieee1394               99896  2 eth1394,ohci1394
usbcore               121728  1 
8139too                27008  0 
mii                     5632  1 8139too
crc32                   4608  1 8139too
agpgart                35020  1 ati_agp


/dev/hda:
 Timing cached reads:    56 MB in  2.01 seconds =  27.92 MB/sec
 Timing buffered disk reads:   16 MB in  3.26 seconds =   4.90 MB/sec



On Mon, 2005-10-31 at 00:38 +0100, Stefan wrote:
> David Ronis wrote:
> 
> >Hi Stefan,
> >
> >The lspci -v output is in the email I sent to Mark (and cc'd the list).
> >  
> >
> 
> Ah I missed that, just took a peek at the irqs
> 
> Can you try to unload those modules for the pccard stuff and usb and
> then check if that makes any difference?
> I have the feeling, your problem is caused by some other modules.
> 
> >I diff'ed the output, and there are lots of differences; most seem
> >trivial (addresses & IRQ's).   As to switching to the lower modes I'll
> >try (maybe later tonight).
> >  
> >
> 
> 
> >Thanks for your help.
> >
> >David
> >
> >
> >  
> >
> >>
> >>    
> >>
> >
> >
> >  
> >
> 
> 
> 	
> 
> 	
> 		
> ___________________________________________________________ 
> Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
> 

