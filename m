From: "Shem Multinymous" <multinymous-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debugging strange system lockups possibly
	triggered by ATA commands
Date: Mon, 9 Oct 2006 14:12:18 +0200
Message-ID: <41840b750610090512j42588537u16994de23d22cf38@mail.gmail.com>
References: <877iz9ohbe.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <hdaps-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <877iz9ohbe.fsf-tKmc6CDQn9GVtrcxygCVqg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=hdaps-devel>
List-Post: <mailto:hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: hdaps-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: hdaps-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Elias,

On 10/9/06, Elias Oltmanns <oltmanns-OhoefBWHl6Eb1SvskN2V4Q@public.gmane.org> wrote:

> A slightly stripped version of the patch is available too, which has
> been verified to trigger the described problem in exactly the same way
> as the original but lacks the IDLE IMMEDIATE feature (leaving the
> STANDBY IMMEDIATE option only) in order to make it (hopefully) more
> readable and easier to understand.

What happens if you strip away *all* the head parking code, leaving
only the queue freeze code? Conversely, what happens if you issue the
head park command but don't freeze the queue?

  Shem

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
