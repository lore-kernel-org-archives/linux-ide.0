From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Wed, 15 Jul 2015 13:53:57 -0400
Message-ID: <20150715175357.GG15934@mtj.duckdns.org>
References: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
 <1436961277-4069-2-git-send-email-arne_f@ipfire.org>
 <55A69715.20901@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A69715.20901@cogentembedded.com>
Sender: stable-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Arne Fitzenreiter <arne_f@ipfire.org>, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Wed, Jul 15, 2015 at 08:23:33PM +0300, Sergei Shtylyov wrote:
> >@@ -431,6 +431,8 @@ enum {
> >  	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
> >  	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
> >  	ATA_HORKAGE_NO_NCQ_LOG	= (1 << 23),	/* don't use NCQ for log read */
> >+	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
> 
>    BTW, why not ATA_HORKAGE_NO_TRIM like the others?

We actually have a bunch of NOXXX's.  We prolly wanna clean them up
together later but things like this ultimately don't really matter.

> >+
> 
>    Empty line not needed here.

I removed it while merging a later patch.

Thanks.

-- 
tejun
