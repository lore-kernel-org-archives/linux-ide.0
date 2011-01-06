From: Jan Ceuleers <jan.ceuleers@computer.org>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 06 Jan 2011 17:10:21 +0100
Message-ID: <4D25E96D.10400@computer.org>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com> <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com> <4D2247A3.2060506@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080102000805020404060603"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:28103 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752800Ab1AFQL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 11:11:57 -0500
In-Reply-To: <4D2247A3.2060506@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080102000805020404060603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/01/11 23:03, Peter M. Petrakis wrote:
> Ah you mean /sys/block/sda/queue/rotational.

A few data points:

- Four rotational disks in my server are correctly reported as such.

- The rotational disk in my laptop is as well.

- The Intel SSD in my set-top box is reported correctly as non-rotational.

- However, the CompactFlash card in my broadband router is incorrectly 
reported as rotational. I attach lshw for this system.

Cheers, Jan

--------------080102000805020404060603
Content-Type: text/plain;
 name="lshw.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lshw.txt"

skr03
    description: Computer
    width: 32 bits
  *-core
       description: Motherboard
       physical id: 0
     *-memory
          description: System memory
          physical id: 0
          size: 497MiB
     *-cpu
          product: Geode(TM) Integrated Processor by AMD PCS
          vendor: Advanced Micro Devices [AMD]
          physical id: 1
          bus info: cpu@0
          version: 5.10.2
          size: 500MHz
          width: 32 bits
          capabilities: fpu fpu_exception wp de pse tsc msr cx8 pge cmov clflush mmx mmxext 3dnowext 3dnow up
        *-cache:0
             description: L1 cache
             physical id: 0
             size: 128KiB
        *-cache:1
             description: L2 cache
             physical id: 1
             size: 128KiB
     *-pci
          description: Host bridge
          product: CS5536 [Geode companion] Host Bridge
          vendor: Advanced Micro Devices [AMD]
          physical id: 100
          bus info: pci@0000:00:01.0
          version: 33
          width: 32 bits
          clock: 66MHz
          configuration: latency=248
        *-generic
             description: Entertainment encryption device
             product: Geode LX AES Security Block
             vendor: Advanced Micro Devices [AMD]
             physical id: 1.2
             bus info: pci@0000:00:01.2
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: bus_master
             configuration: driver=Geode LX AES latency=0
             resources: irq:10 memory:a0000000-a0003fff
        *-network:0 DISABLED
             description: Ethernet interface
             product: VT6105M [Rhine-III]
             vendor: VIA Technologies, Inc.
             physical id: 6
             bus info: pci@0000:00:06.0
             logical name: eth0
             version: 96
             serial: 00:00:24:cc:96:90
             size: 10MB/s
             capacity: 100MB/s
             width: 32 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=via-rhine driverversion=1.4.3 duplex=half latency=176 link=no maxlatency=8 mingnt=3 multicast=yes port=MII speed=10MB/s
             resources: irq:11 ioport:e100(size=256) memory:a0004000-a00040ff
        *-network:1 DISABLED
             description: Ethernet interface
             product: VT6105M [Rhine-III]
             vendor: VIA Technologies, Inc.
             physical id: 7
             bus info: pci@0000:00:07.0
             logical name: eth1
             version: 96
             serial: 00:00:24:cc:96:91
             size: 10MB/s
             capacity: 100MB/s
             width: 32 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=via-rhine driverversion=1.4.3 duplex=half latency=176 link=no maxlatency=8 mingnt=3 multicast=yes port=MII speed=10MB/s
             resources: irq:5 ioport:e200(size=256) memory:a0004100-a00041ff
        *-network:2
             description: Ethernet interface
             product: VT6105M [Rhine-III]
             vendor: VIA Technologies, Inc.
             physical id: 8
             bus info: pci@0000:00:08.0
             logical name: eth2
             version: 96
             serial: 00:00:24:cc:96:92
             size: 10MB/s
             capacity: 100MB/s
             width: 32 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=via-rhine driverversion=1.4.3 duplex=half ip=10.20.0.1 latency=176 link=no maxlatency=8 mingnt=3 multicast=yes port=MII speed=10MB/s
             resources: irq:9 ioport:e300(size=256) memory:a0004200-a00042ff
        *-network:3
             description: Ethernet interface
             product: VT6105M [Rhine-III]
             vendor: VIA Technologies, Inc.
             physical id: 9
             bus info: pci@0000:00:09.0
             logical name: eth3
             version: 96
             serial: 00:00:24:cc:96:93
             size: 100MB/s
             capacity: 100MB/s
             width: 32 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=via-rhine driverversion=1.4.3 duplex=full latency=176 link=yes maxlatency=8 mingnt=3 multicast=yes port=MII speed=100MB/s
             resources: irq:12 ioport:e400(size=256) memory:a0004300-a00043ff
        *-network:4
             description: Ethernet interface
             product: RTL-8139/8139C/8139C+
             vendor: Realtek Semiconductor Co., Ltd.
             physical id: e
             bus info: pci@0000:00:0e.0
             logical name: eth4
             version: 20
             serial: 00:0a:fa:30:00:a4
             size: 100MB/s
             capacity: 100MB/s
             width: 32 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=8139cp driverversion=1.3 duplex=full latency=176 link=yes maxlatency=64 mingnt=32 multicast=yes port=MII promiscuous=yes speed=100MB/s
             resources: irq:10 ioport:e500(size=256) memory:a0004400-a00044ff
        *-network:5
             description: Wireless interface
             product: AR922X Wireless Network Adapter
             vendor: Atheros Communications Inc.
             physical id: 11
             bus info: pci@0000:00:11.0
             logical name: wlan0
             version: 01
             serial: 00:80:48:65:d8:48
             width: 32 bits
             clock: 66MHz
             capabilities: pm bus_master cap_list ethernet physical wireless logical
             configuration: broadcast=yes driver=ath9k latency=168 multicast=yes wireless=IEEE 802.11abgn
             resources: irq:15 memory:a0010000-a001ffff
        *-isa
             description: ISA bridge
             product: CS5536 [Geode companion] ISA
             vendor: Advanced Micro Devices [AMD]
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 03
             width: 32 bits
             clock: 66MHz
             capabilities: isa
             configuration: latency=64
             resources: ioport:6000(size=8192) ioport:1400(size=256) ioport:1000(size=512)
        *-ide
             description: IDE interface
             product: CS5536 [Geode companion] IDE
             vendor: Advanced Micro Devices [AMD]
             physical id: 14.2
             bus info: pci@0000:00:14.2
             logical name: scsi0
             version: 01
             width: 32 bits
             clock: 66MHz
             capabilities: ide bus_master emulated
             configuration: driver=pata_amd latency=0
             resources: irq:0 ioport:1f0(size=8) ioport:3f6 ioport:170(size=8) ioport:376 ioport:e000(size=16)
           *-disk
                description: ATA Disk
                product: SanDisk SDCFH2-0
                physical id: 0.0.0
                bus info: scsi@0:0.0.0
                logical name: /dev/sda
                version: HDX
                serial: 014205J0808G1218
                size: 3919MiB (4110MB)
                capabilities: removable
                configuration: ansiversion=5
              *-medium
                   physical id: 0
                   logical name: /dev/sda
                   size: 3919MiB (4110MB)
                   capabilities: partitioned partitioned:dos
                   configuration: signature=0009d403
                 *-volume:0
                      description: Linux filesystem partition
                      vendor: Linux
                      physical id: 1
                      logical name: /dev/sda1
                      logical name: /
                      version: 1.0
                      serial: 198bbce8-57d4-4b24-8732-c6bd1f56dc81
                      size: 3638MiB
                      capacity: 3638MiB
                      capabilities: primary bootable ext2 initialized
                      configuration: filesystem=ext2 modified=2011-01-06 17:06:24 mount.fstype=ext2 mount.options=rw,relatime,errors=remount-ro mounted=2010-12-21 19:56:30 state=mounted
                 *-volume:1
                      description: Extended partition
                      physical id: 2
                      logical name: /dev/sda2
                      size: 244MiB
                      capacity: 244MiB
                      capabilities: primary extended partitioned partitioned:extended
                    *-logicalvolume
                         description: Linux swap / Solaris partition
                         physical id: 5
                         logical name: /dev/sda5
                         capacity: 244MiB
                         capabilities: nofs
        *-usb:0
             description: USB Controller
             product: CS5536 [Geode companion] OHC
             vendor: Advanced Micro Devices [AMD]
             physical id: 15
             bus info: pci@0000:00:15.0
             version: 02
             width: 32 bits
             clock: 66MHz
             capabilities: bus_master cap_list
             configuration: driver=ohci_hcd latency=0
             resources: irq:7 memory:a0020000-a0020fff
        *-usb:1
             description: USB Controller
             product: CS5536 [Geode companion] EHC
             vendor: Advanced Micro Devices [AMD]
             physical id: 15.1
             bus info: pci@0000:00:15.1
             version: 02
             width: 32 bits
             clock: 66MHz
             capabilities: bus_master cap_list
             configuration: driver=ehci_hcd latency=0
             resources: irq:7 memory:a0021000-a0021fff

--------------080102000805020404060603--
