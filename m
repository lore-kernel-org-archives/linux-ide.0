From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] remove ide-scsi
Date: Wed, 3 Dec 2008 06:55:51 -0700
Message-ID: <20081203135550.GC25548@parisc-linux.org>
References: <20081203103856S.fujita.tomonori@lab.ntt.co.jp> <20081203100643.GA29340@infradead.org> <150283e90812030531o764b53b8w5bc655085ca4f106@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <150283e90812030531o764b53b8w5bc655085ca4f106@mail.gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Willem Riede <osst@riede.org>
Cc: Christoph Hellwig <hch@infradead.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, bzolnier@gmail.com, James.Bottomley@hansenpartnership.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Dec 03, 2008 at 06:31:15AM -0700, Willem Riede wrote:
> On Wed, Dec 3, 2008 at 3:06 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > Isn't ide-scsi the only way to use ATAPI OnStream tapes supported by
> > the osst driver?
>
> You are right. There are IDE versions of the OnStream drives that need ide-scsi.
> There are also SCSI versions of the OnStream, which work with osst directly.

Why can't osst / libata support the IDE versions of the OnStream drives?
What code needs to be written?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
