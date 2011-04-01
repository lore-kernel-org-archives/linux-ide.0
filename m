From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Commit 7eaceaccab5f40 causing boot hang.
Date: Fri, 01 Apr 2011 08:26:37 -0400
Message-ID: <4D95C47D.206@teksavvy.com>
References: <201103291551.p2TFpDqZ001692@clem.clem-digital.net> <4D92C874.7040104@parallels.com> <4D931634.5030807@fusionio.com> <4D933584.5050005@parallels.com> <4D94432D.5080601@fusionio.com> <4D944544.9040705@parallels.com> <4D945247.4080404@fusionio.com> <4D945976.8000401@fusionio.com> <4D945BAD.10309@parallels.com> <4D9460F8.7080606@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D9460F8.7080606@fusionio.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Rob Landley <rlandley@parallels.com>, Pete Clements <clem@clem.clem-digital.net>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On 11-03-31 07:09 AM, Jens Axboe wrote:
..
> 
> Data point - only seems to happen on UP. If you add -smp X to kvm, then
> it boots and works just fine. It smells oddly like some sort of irq
> event.


Like perhaps an IRQ waiting on a spinlock that's held elsewhere ?
