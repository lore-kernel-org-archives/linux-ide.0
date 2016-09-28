From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] Enabling ATA Command Priorities
Date: Tue, 27 Sep 2016 19:06:10 -0700
Message-ID: <20160928020610.GA28998@infradead.org>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
Sender: linux-block-owner@vger.kernel.org
To: Adam Manzanares <adam.manzanares@hgst.com>
Cc: axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The series looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

The only question is if we need to bother with the last patch to
make the feature conditional at all, given that we both need hardware
support and applications opting into using I/O priorities to even use
it.  But if you feel it's safer that way the unable certainly doesn't
hurt.
