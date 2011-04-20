From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
	boot on parisc
Date: Wed, 20 Apr 2011 08:56:16 -0600
Message-ID: <20110420145616.GB31296@parisc-linux.org>
References: <1303152147.7167.12.camel@mulgrave.site> <20110418205203.56bbdb14@lxorguk.ukuu.org.uk> <1303159802.7167.30.camel@mulgrave.site> <20110418222017.4e77fe05@lxorguk.ukuu.org.uk> <4DADF798.6010705@ru.mvista.com> <20110419221900.67528a07@lxorguk.ukuu.org.uk> <4DADFD2E.9070809@ru.mvista.com> <20110419222838.6a6f36aa@lxorguk.ukuu.org.uk> <1303254709.11237.34.camel@mulgrave.site> <4DAEAF9A.1020704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DAEAF9A.1020704@ru.mvista.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Apr 20, 2011 at 02:04:10PM +0400, Sergei Shtylyov wrote:
>> +#define PCI_VENDOR_ID_MOBILITY_ELECTRONICS	0x14f2
>> +
>
>    The current trend seems to be to only define vendor/device IDs where 
> they are used and not in pci_ids.h...

Device IDs, yes.  Vendor IDs should always go to the pci_ids.h file, since
they're likely to be used in multiple places.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
