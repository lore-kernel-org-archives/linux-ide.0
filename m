From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] AHCI: Remove conflicting Intel Lewisburg 3rd-party SATA
 RAID device IDs
Date: Mon, 29 Feb 2016 16:31:03 +0000
Message-ID: <20160229163103.00504b12@lxorguk.ukuu.org.uk>
References: <20160227112033.GX3965 () htj ! duckdns ! org>
	<1456737781-13494-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456737781-13494-1-git-send-email-hehy1@lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 29 Feb 2016 09:28:19 +0000
Ocean HY1 He <hehy1@lenovo.com> wrote:

> Hi Tejun,
> 
> According to Intel Lewisburg PCH EDS, SATA RAID controller has two types
> of DIDs: RSTe RAID and 3rd Party RAID. RSTe RAID shoud be drived by AHCI
> driver and used to construct MDRAID. These 3rd Party RAID IDs are reserved
> for other 3rd Party RAID drivers for variety.
> 
> So, I think it's a bug to let AHCI driver supporting 3rd Party RAID IDs.
> And it should be ok to remove these existed device IDs.

We have already had this discussion before. I'm surprised it has come
back again, this time via Intel. If Lenovo wants their RAID supported in
Linux then contribute it open source to the kernel. You've been told this
clearly before.

Alan
