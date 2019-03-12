From: LABBE Corentin <clabbe@baylibre.com>
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Date: Tue, 12 Mar 2019 11:41:02 +0100
Message-ID: <20190312104102.GA28302@Red>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
 <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: axboe@kernel.dk, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Dec 10, 2018 at 05:52:35PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 12/10/2018 04:46 PM, Corentin Labbe wrote:
> 
> > When playing with a virtual SPARC machine with qemu, I found that the
> > IDE emulated device was not probing with the ata/pata_oldpiix driver.
> 
>    Correctly, it should probe with ata_piix,
> 
> > But with the old ide/piix, it was probed.> 
> > This is due to this PCI devid was not migrated from the old ide/piix.
> 
>    It wasn't on purpose -- the IDE driver supports the original PIIX
> incorrectly.
> 

Hello

What about removing this old driver totally if it dont work ?

Regards
