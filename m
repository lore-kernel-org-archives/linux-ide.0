From: Christoph Hellwig <hch@lst.de>
Subject: Re: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Sun, 27 Aug 2017 11:05:46 +0200
Message-ID: <20170827090546.GA16766@lst.de>
References: <20170824112932.GA12461@shredder.mtl.com> <20170824120728.GA23186@lst.de> <20170824121804.GA14057@shredder.mtl.com> <20170826171537.GA4755@shredder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:33649 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbdH0JFr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 27 Aug 2017 05:05:47 -0400
Content-Disposition: inline
In-Reply-To: <20170826171537.GA4755@shredder>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ido Schimmel <idosch@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org, xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

On Sat, Aug 26, 2017 at 08:15:37PM +0300, Ido Schimmel wrote:
> On Thu, Aug 24, 2017 at 03:18:04PM +0300, Ido Schimmel wrote:
> > On Thu, Aug 24, 2017 at 02:07:29PM +0200, Christoph Hellwig wrote:
> > > What kind of device is this?   Seems like we need to blacklist it
> > > as it chokes when we tried to read the Identify Devіce Log.
> > 
> > Is the below enough or do you need more info?
> 
> Ping?

Sorry, been a bit busy.  Is this an actual SSD connected to a real
controller, or a PCIe SSD that implements ahci itself?

Can you send the full dmesg output, plus lspci -v, plus the output of
hdparm -i /dev/sdN for the device after a working boot?
