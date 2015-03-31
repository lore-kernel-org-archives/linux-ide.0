From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
Date: Tue, 31 Mar 2015 16:36:27 +0100
Message-ID: <20150331153627.GA8200@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
 <1427787309-1601-4-git-send-email-peter.griffin@linaro.org>
 <20150331152958.GF9974@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150331152958.GF9974-piEFEHQLUPpN0TnZuCh8vA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Tue, 31 Mar 2015, Tejun Heo wrote:

> On Tue, Mar 31, 2015 at 08:35:09AM +0100, Peter Griffin wrote:
> > Currently the ahci_st driver will hang the system on probe, as the
> > st_configure_oob function does some register writes before the IP
> > is clocked. This patch moves the function call to after
> > ahci_platform_enable_resources (which enables the IP clock), and
> > resolves the hang.
> > 
> > Addtionally st_ahci_configure_oob should be called in the st_ahci_resume
> > function, so we also rectify that ensuring it is also called after
> > the IP clock has been enabled.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
> 
> How should this patch be routed?  Should I pick this up and apply to
> libata/for-4.1 or should it go together with the other patches?  If
> the latter, please feel free to add my acked-by.

This patch (and also the DT documentation change) can go via your tree. Maxime
will take the stih407 DT patch.

regards,

Peter.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
