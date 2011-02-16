From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: old ide driver incompatible with new flush implementation
	 (was: conflicting commits (block flush vs. ide))
Date: Wed, 16 Feb 2011 11:31:34 +0000
Message-ID: <4D5BC3A6020000780003228A@vpn.id2.novell.com>
References: <4D5A75650200007800031F9C@vpn.id2.novell.com>
 <20110215151314.GJ3160@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20110215151314.GJ3160@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

>>> On 15.02.11 at 16:13, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Feb 15, 2011 at 11:45:25AM +0000, Jan Beulich wrote:
>> Actually, the situation is worse. While the patch sent previously
>> allowed that system to boot, it died the moment it tried to
>> access its secondary disk (which supports flushes, while the
>> primary doesn't):
>
> Yeah, right.  blk_flush_complete_seq_end_io() is on completion path
> and shouldn't call directly into request_fn.  Can you please test
> whether the following patch fixes the problem?

Indeed, this plus the small second patch you sent a little later gets
things into proper shape again on that box.

I assume you'll try to get this merged for .38 (and then probably
backported to .37.x).

Thanks, Jan

