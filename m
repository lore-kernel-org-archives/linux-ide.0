From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Date: Tue, 12 Mar 2019 12:06:23 +0000
Message-ID: <20190312120623.46ca7286@alans-desktop>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
        <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
        <20190312104102.GA28302@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312104102.GA28302@Red>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe@baylibre.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, axboe@kernel.dk, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 12 Mar 2019 11:41:02 +0100
LABBE Corentin <clabbe@baylibre.com> wrote:

> On Mon, Dec 10, 2018 at 05:52:35PM +0300, Sergei Shtylyov wrote:
> > Hello!
> > 
> > On 12/10/2018 04:46 PM, Corentin Labbe wrote:
> >   
> > > When playing with a virtual SPARC machine with qemu, I found that the
> > > IDE emulated device was not probing with the ata/pata_oldpiix driver.  
> > 
> >    Correctly, it should probe with ata_piix,
> >   
> > > But with the old ide/piix, it was probed.> 
> > > This is due to this PCI devid was not migrated from the old ide/piix.  
> > 
> >    It wasn't on purpose -- the IDE driver supports the original PIIX
> > incorrectly.
> >   
> 
> Hello
> 
> What about removing this old driver totally if it dont work ?

If the virtual Sparc emulator is using it does that also mean actual
Sparc hardware has it. In which case presumably it needs fixing, or at
least moving to the generic driver assuming the firmware sets it up ?

Alan
