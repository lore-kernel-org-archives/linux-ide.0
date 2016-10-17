From: Christoph Hellwig <hch@lst.de>
Subject: Re: use pci_alloc_irq_vectors issues
Date: Mon, 17 Oct 2016 22:55:17 +0200
Message-ID: <20161017205517.GA27244@lst.de>
References: <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com> <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com> <20161017103442.GA12240@lst.de> <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com> <20161017120234.GA14105@lst.de> <CA+i8gK+UfUmKtYpXH1cObd3_5WWje397pgQqW5SmwFg8ms+aLw@mail.gmail.com> <20161017192858.GA25429@lst.de> <CA+i8gKJ6dyxHm-5_=Xdm=HusyxsHVbqTphGzMp1zBTMut=yygQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+i8gKJ6dyxHm-5_=Xdm=HusyxsHVbqTphGzMp1zBTMut=yygQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Oct 17, 2016 at 10:51:44PM +0200, Emmanuel Benisty wrote:
> This patch solved the issue, thanks a lot.

Thanks for testing!

I'll resend it to Tejun with proper indentation and a changelog
tomorrow.
