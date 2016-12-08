From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 00/19] ide: remove deprecated host drivers (part 1)
Date: Thu, 8 Dec 2016 09:11:14 -0800
Message-ID: <20161208171114.GA29203@infradead.org>
References: <3280015.pSoKvQuVNQ@amdc3058>
 <20161208.102308.460750923427290066.davem@davemloft.net>
 <5007114.YSRHeGyTgl@amdc3058>
 <20161208.113957.686350007074631834.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208.113957.686350007074631834.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org, gnomes@lxorguk.ukuu.org.uk, sergei.shtylyov@cogentembedded.com
List-Id: linux-ide@vger.kernel.org

On Thu, Dec 08, 2016 at 11:39:57AM -0500, David Miller wrote:
> They are not a maintainence burdon, I rarely get more than 1 patch
> each merge window and most of the time those are cleanups or for the
> handling of a kernel wide API change rather than bug fixes.

They are a major maintainence burden for the block layer due to horrible
abuse of all kinds of block layer APIs.
