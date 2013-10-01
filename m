From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: Enable ahci sata and sata phy
Date: Tue, 1 Oct 2013 12:16:55 +0530
Message-ID: <CAK9yfHy8XUpigc0VU_h-rCUUukirFALfnjQ5_aHzB-6O0UydEA@mail.gmail.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
	<1380609183-21430-4-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380609183-21430-4-git-send-email-yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuvaraj Kumar C D <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, GIRISH K S <ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "aditya.ps" <aditya.ps-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Yuvaraj Kumar C D <yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Yuvaraj,

On 1 October 2013 12:03, Yuvaraj Kumar C D <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This patch adds dt entry for ahci sata controller and its
> corresponding phy controller.phy node has been added w.r.t
> new generic phy framework.

[snip]
> +
> +               sata-phy {

Shouldn't this be sata-phy@38?

> +                       compatible = "sata-phy-i2c";
> +                       reg = <0x38>;
> +               };

[snip]
> -       sata-phy@12170000 {
> -               compatible = "samsung,exynos5-sata-phy";
> +       sata_phy:sata-phy@12170000 {

nit: A space after sata_phy: would be good.


-- 
With warm regards,
Sachin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
