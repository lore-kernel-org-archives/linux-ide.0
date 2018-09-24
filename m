From: Jens Axboe <axboe@kernel.dk>
Subject: Re: libata-core WARNING during boot
Date: Mon, 24 Sep 2018 13:19:52 -0600
Message-ID: <0d5420a4-dd7c-1810-2fbd-0840372a5ba3@kernel.dk>
References: <b9b55c84-a90c-e7ac-add7-fdf1b7e13dc6@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9b55c84-a90c-e7ac-add7-fdf1b7e13dc6@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 9/23/18 9:34 PM, Randy Dunlap wrote:
> Hi,
> 
> I'm having (repeatable) problems booting 4.18 and 4.18.9 (latest stable):
> 
> WARNING: CPU: 1 PID: 1 at ../drivers/ata/libata-core.c:6677 ata_host_detach+0x6e/0x150
> 
> 
> It never completes the boot.  Could that be due to this eh warning?

Is this a new issue? Not quite clear based on your report.

-- 
Jens Axboe
