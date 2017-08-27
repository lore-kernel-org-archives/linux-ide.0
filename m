From: Ido Schimmel <idosch@mellanox.com>
Subject: Re: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Sun, 27 Aug 2017 13:53:31 +0300
Message-ID: <20170827105331.GA18386@shredder.mtl.com>
References: <20170824112932.GA12461@shredder.mtl.com>
 <20170824120728.GA23186@lst.de>
 <20170824121804.GA14057@shredder.mtl.com>
 <20170826171537.GA4755@shredder>
 <20170827090546.GA16766@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:2086
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750787AbdH0Kxj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 27 Aug 2017 06:53:39 -0400
Content-Disposition: inline
In-Reply-To: <20170827090546.GA16766@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

Hi Christoph,

On Sun, Aug 27, 2017 at 11:05:46AM +0200, Christoph Hellwig wrote:
> On Sat, Aug 26, 2017 at 08:15:37PM +0300, Ido Schimmel wrote:
> > On Thu, Aug 24, 2017 at 03:18:04PM +0300, Ido Schimmel wrote:
> > > On Thu, Aug 24, 2017 at 02:07:29PM +0200, Christoph Hellwig wrote:
> > > > What kind of device is this?   Seems like we need to blacklist it
> > > > as it chokes when we tried to read the Identify Devіce Log.
> > > 
> > > Is the below enough or do you need more info?
> > 
> > Ping?
> 
> Sorry, been a bit busy.  Is this an actual SSD connected to a real
> controller, or a PCIe SSD that implements ahci itself?

Yes, it's an actual SSD. Not PCIe.

> Can you send the full dmesg output, plus lspci -v, plus the output of
> hdparm -i /dev/sdN for the device after a working boot?

dmesg from 4.12.8 kernel:
https://pastebin.com/HjMFqrP8

lspci -v from 4.12.8 kernel:
https://pastebin.com/UFnKVmg9

hdparm -i from 4.12.8 kernel:
https://pastebin.com/GdCVcj3G

dmesg from 4.13-rc6 kernel where the error is showed:
https://pastebin.com/uVLRsybx

Thank you for your time.
