From: "George Spelvin" <linux@horizon.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Mon, 29 Sep 2008 22:00:02 -0400
Message-ID: <20080930020002.26564.qmail@science.horizon.com>
References: <20080920151712.10515.qmail@science.horizon.com>
 <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>
 <20080921001529.23400.qmail@science.horizon.com>
 <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com>
 <48DA0C8B.3000406@gmail.com>
 <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com>
 <20080925032437.6802.qmail@science.horizon.com>
 <48DCEC6D.1040305@gmail.com>
 <20080928210422.2578.qmail@science.horizon.com>
 <48E0112C.7010901@gmail.com>
 <20080929040812.8784.qmail@science.horizon.com>
 <48E058D2.7050704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:19388 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753199AbYI3CAG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 22:00:06 -0400
In-Reply-To: <48E058D2.7050704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com, htejun@gmail.com
Cc: Shane.Huang@amd.com, mdnelson8@gmail.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, grundler@google.com

Tejun Heo <htejun@gmail.com> wrote:

> George Spelvin wrote:
>> ATM I'm just recompiling the kernel from -rc6 to -rc7.
>> 
>> It's in single-user mode so I can't ssh over the boot messages, but
>> they definitely included "64bit" from ahci_print_info().
>
> Thanks for verifying.  I would love to lift the 32 restriction from
> SB600 but it's been quite a rocky ride and I still can't tell what's
> the determining factor.  :-(

H'm.... 64-bit support comes through in multiple places.
I wonder if it's just one of them?
- HBA memory-mapped registers (which are in fact limited to 32 bits)
- Port x command list base address
- Port x FIS base address
- Command table base address (command header, offset 8)
- Data base address (physical region descriptor, offset 0)

What we really care about is that the data physical regions can
be anywhere in 64-bit space.  If any of the others were limited to
32 bits, that would only be slightly annoying.

But...
The base addresses are already above 4G.  Aobve 8G, actually.

Port 0 base addresses: 02 1f1e 0000, 02 1f1e 0400
Port 1 base addresses: 02 1f1a 0000, 02 1f1a 0400
Port 2 base addresses: 02 1f98 0000, 02 1f98 0400
Port 3 base addresses: 02 1f9e 0000, 02 1f9e 0400

/proc/iomem looks like:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000c0000-000cffff : pnp 00:0e
000e4000-000fffff : reserved
00100000-dffbffff : System RAM
  00200000-005187db : Kernel code
  005187dc-006c310f : Kernel data
  0073f000-007bb4cf : Kernel bss
  20000000-23ffffff : GART
dffc0000-dffcdfff : ACPI Tables
dffce000-dffeffff : ACPI Non-volatile Storage
dfff0000-dfffdfff : reserved
e0000000-efffffff : PCI MMCONFIG 0
fc000000-fdffffff : PCI Bus 0000:03
  fc000000-fdffffff : 0000:03:00.0
fe7f4000-fe7f7fff : 0000:00:14.2
fe7fa000-fe7fafff : 0000:00:13.4
  fe7fa000-fe7fafff : ohci_hcd
fe7fb000-fe7fbfff : 0000:00:13.3
  fe7fb000-fe7fbfff : ohci_hcd
fe7fc000-fe7fcfff : 0000:00:13.2
  fe7fc000-fe7fcfff : ohci_hcd
fe7fd000-fe7fdfff : 0000:00:13.1
  fe7fd000-fe7fdfff : ohci_hcd
fe7fe000-fe7fefff : 0000:00:13.0
  fe7fe000-fe7fefff : ohci_hcd
fe7ff000-fe7ff0ff : 0000:00:13.5
  fe7ff000-fe7ff0ff : ehci_hcd
fe7ff800-fe7ffbff : 0000:00:12.0
  fe7ff800-fe7ffbff : ahci
fe800000-fe8fffff : PCI Bus 0000:01
  fe8c0000-fe8dffff : 0000:01:00.0
  fe8ff000-fe8fffff : 0000:01:00.0
    fe8ff000-fe8fffff : r8169
fe900000-fe9fffff : PCI Bus 0000:02
  fe9c0000-fe9dffff : 0000:02:00.0
    fe9c0000-fe9dffff : ahci
  fe9fc000-fe9fdfff : 0000:02:00.0
    fe9fc000-fe9fdfff : ahci
  fe9ff000-fe9fffff : 0000:02:00.0
    fe9ff000-fe9fffff : ahci
fea00000-feafffff : PCI Bus 0000:03
  feac0000-feadffff : 0000:03:00.0
  feae0000-feaeffff : 0000:03:00.1
  feaf0000-feafffff : 0000:03:00.0
feb00000-febfffff : PCI Bus 0000:04
  febff800-febfffff : 0000:04:00.0
fec00000-fec00fff : IOAPIC 0
fed00000-fed003ff : HPET 2
fee00000-fee00fff : Local APIC
fff00000-ffffffff : reserved
100000000-21fffffff : System RAM

