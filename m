From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Thu, 21 Apr 2011 10:24:09 -0400
Message-ID: <4DB03E09.7030100@garzik.org>
References: <1303152147.7167.12.camel@mulgrave.site> <20110418205203.56bbdb14@lxorguk.ukuu.org.uk> <1303159802.7167.30.camel@mulgrave.site> <20110418222017.4e77fe05@lxorguk.ukuu.org.uk> <4DADF798.6010705@ru.mvista.com> <20110419221900.67528a07@lxorguk.ukuu.org.uk> <4DADFD2E.9070809@ru.mvista.com> <20110419222838.6a6f36aa@lxorguk.ukuu.org.uk> <1303254709.11237.34.camel@mulgrave.site> <4DAEAF9A.1020704@ru.mvista.com> <20110420145616.GB31296@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20110420145616.GB31296@parisc-linux.org>
Sender: linux-parisc-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 04/20/2011 10:56 AM, Matthew Wilcox wrote:
> On Wed, Apr 20, 2011 at 02:04:10PM +0400, Sergei Shtylyov wrote:
>>> +#define PCI_VENDOR_ID_MOBILITY_ELECTRONICS	0x14f2
>>> +
>>
>>     The current trend seems to be to only define vendor/device IDs where
>> they are used and not in pci_ids.h...
>
> Device IDs, yes.  Vendor IDs should always go to the pci_ids.h file, since
> they're likely to be used in multiple places.

Correct; that's the current libata policy.

	Jeff



