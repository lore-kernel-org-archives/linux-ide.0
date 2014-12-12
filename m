From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] libata: export ata_get_cmd_descript()
Date: Fri, 12 Dec 2014 19:35:47 +0200
Message-ID: <1418405747.17201.64.camel@linux.intel.com>
References: <1418397391-13668-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <548B2524.9050806@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <548B2524.9050806@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, 2014-12-12 at 20:25 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/12/2014 06:16 PM, Andy Shevchenko wrote:
> 
> > The driver sata_dwc_460ex is using this symbol. To build it as a module we have
> > to have the symbol exported. This patch adds EXPORT_SYMBOL() macro for that.
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/ata/libata-eh.c | 1 +
> >   1 file changed, 1 insertion(+)
> 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 3dbec89..74fef87 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -2389,6 +2389,7 @@ const char *ata_get_cmd_descript(u8 command)
> >
> >   	return NULL;
> >   }
> > +EXPORT_SYMBOL(ata_get_cmd_descript);
> 
>     Why not EXPORT_SYMBOL_GPL()?

Some of the symbols are exported in that way. I think better to wait the
maintainer to tell which is preferred there.

> 
> MBR, Sergei
> 


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
