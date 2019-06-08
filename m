From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
Date: Sat, 8 Jun 2019 01:25:52 -0700
Message-ID: <20190608082552.GA9613@infradead.org>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <155989287898.1506.14253954112551051148.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 07, 2019 at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
> Print trim status once at ata device initialization in form:

Do we really need to spam dmesg with even more ATA crap?  What about
a sysfs file that can be read on demand instead?
