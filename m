From: Mike Snitzer <snitzer@gmail.com>
Subject: Re: [PATCH v2.6.38-rc5 2/2] block: blk-flush shouldn't call directly
 into q->request_fn() __blk_run_queue()
Date: Thu, 17 Feb 2011 10:01:51 -0500
Message-ID: <AANLkTi=rPKN25yZTziv1dz=Ke0db8ZOwUgKFNzWn9+x7@mail.gmail.com>
References: <20110217111511.GQ19830@htj.dyndns.org> <20110217111619.GR19830@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110217111619.GR19830@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Beulich <JBeulich@novell.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Thu, Feb 17, 2011 at 6:16 AM, Tejun Heo <tj@kernel.org> wrote:

> Jens, this is applicable to v2.6.37 and 38. =A0The new implementation
> for 39 would need similar fix but I couldn't find where the tree is.
> Which branch is it?

for-2.6.39/core
