From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: kernel unaligned accesses on IA64 in IDE
Date: Fri, 22 Aug 2008 22:41:42 +0200
Message-ID: <20080822204142.GA5468@gollum.tnic>
References: <20080819225606.GB22088@us.ibm.com> <20080822164538.GB9047@us.ibm.com> <9ea470500808221029l6bd79c62w4c06d948f962d95c@mail.gmail.com> <200808222036.00536.bzolnier@gmail.com> <57C9024A16AD2D4C97DC78E552063EA309EDE187@orsmsx505.amr.corp.intel.com> <200808222036.m7MKa6bT008897@agluck-lia64.sc.intel.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200808222036.m7MKa6bT008897@agluck-lia64.sc.intel.com>
Sender: linux-ia64-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Robin Holt <holt@sgi.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Nishanth Aravamudan <nacc@us.ibm.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 22, 2008 at 01:36:06PM -0700, Luck, Tony wrote:
> > How about long instead of int.  int leaves us with the possibility that
> > something else will expect 8 byte alignment.
> 
> How about this?
> 
> Align __cmd to ward off kernel unaligned access consoles messages on
> ia64 (and perhaps make an almost imperceptible performance improvement
> on other architectures that can handle unaligned access, but do so
> more slowly than aligned accesses).

That's probably the best solution for now. Testing...

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e61f22b..a493a4b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -211,7 +211,7 @@ struct request {
>  	 * when request is used as a packet command carrier
>  	 */
>  	unsigned short cmd_len;
> -	unsigned char __cmd[BLK_MAX_CDB];
> +	unsigned char __cmd[BLK_MAX_CDB] __attribute__((aligned(8)));
>  	unsigned char *cmd;
>  
>  	unsigned int data_len;

-- 
Regards/Gruss,
    Boris.
