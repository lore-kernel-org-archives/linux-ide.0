From: Evgeni Golov <sargentd@die-welt.net>
Subject: Re: Odd behaviour of device in response to idleimmediate with
 unload
Date: Tue, 4 Nov 2008 13:32:11 +0100
Message-ID: <20081104123211.A86321FD5A@chi.die-welt.net>
References: <871vxrzssj.fsf@denkblock.local>
	<491026AB.1090704@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chi.die-welt.net ([84.246.123.210]:48195 "EHLO chi.die-welt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbYKDNFs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 08:05:48 -0500
In-Reply-To: <491026AB.1090704@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

On Tue, 04 Nov 2008 19:40:43 +0900 Tejun Heo wrote:

> Is it a laptop?

Yes it is, it's a IBM/Lenovo Thinkpad Z61m (9453A11)

> Does 'hdparm -y' cause the same thing?

No, neither -y nor -Y cause these messages.

> Can you post "hdparm -I"?

Here we go:


/dev/sda:

ATA device, with non-removable media
	Model Number:       TOSHIBA MK1032GSX                       
	Serial Number:      MYSERIAL:)
	Firmware Revision:  AS024E  
Standards:
	Supported: 6 5 4 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  195371568
	LBA48  user addressable sectors:  195371568
	device size with M = 1024*1024:       95396 MBytes
	device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 128
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	   *	Advanced Power Management feature set
	    	SET_MAX security extension
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	Device-initiated interface power management
	   *	Software settings preservation
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
	74min for SECURITY ERASE UNIT. 
Checksum: correct

HTH
Evgeni
