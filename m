From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] drivers/ata: cleanup creation of device sysfs attribute
Date: Sat, 8 Jun 2019 01:27:07 -0700
Message-ID: <20190608082707.GB9613@infradead.org>
References: <155989288635.1536.11972713412534297217.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <155989288635.1536.11972713412534297217.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 07, 2019 at 10:34:46AM +0300, Konstantin Khlebnikov wrote:
> This patch merges common ATA and AHCI specific attribute "sw_activity"
> into one group with ->is_visible() method which hides attributes if
> feature is not supported by hardware.
> 
> This allows to add all attributes in one place without exporting
> each piece for linking into another list in ahci module.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
