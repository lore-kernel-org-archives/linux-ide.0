From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide pmac breakage
Date: Tue, 29 Jul 2008 13:41:14 +0200
Message-ID: <200807291341.14724.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop>
	<20080729141750V.fujita.tomonori@lab.ntt.co.jp>
	<1217308857.11188.237.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1217308857.11188.237.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: benh@kernel.crashing.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 29 July 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-29 at 14:17 +0900, FUJITA Tomonori wrote:
> > If q->elevator is NULL, the media-bay code might mess up the ref
> > counting of the request queue...
> 
> Well, all I do is call into Bart's new helpers to scan for or unregister
> devices ...

The switch to these helpers happened _before_ 2.6.26 and it shouldn't bring
such behavior change (ditto for new IDE host addition/removal helpers)...

Please try to git-bisect it when you have some time.

Thanks,
Bart
