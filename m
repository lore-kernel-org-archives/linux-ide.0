From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ahci: exynos: add ahci sata support on Exynos platform
Date: Tue, 1 Oct 2013 12:24:09 +0530
Message-ID: <CAK9yfHxF76YjrdGo0-Yty5QcaJKhvtikWhxySoA6-NxjFDsuTA@mail.gmail.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
	<1380609183-21430-2-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380609183-21430-2-git-send-email-yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuvaraj Kumar C D <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, GIRISH K S <ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "aditya.ps" <aditya.ps-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Yuvaraj Kumar C D <yuvaraj.cd-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Yuvaraj,

On 1 October 2013 12:03, Yuvaraj Kumar C D <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Exynos5250 contains one Synopsys AHCI SATA controller.The avalaible
> ahci_platform driver is not sufficient to handle the AHCI PHY and PHY
> clock related initialization.

> +err_out:
> +               platform_set_drvdata(pdev, NULL);

This is not necessary. Driver core clears it upon detach or failure.

> +               platform_device_put(ahci_pdev);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int exynos_ahci_remove(struct platform_device *pdev)
> +{
> +       struct exynos_ahci_priv *priv = platform_get_drvdata(pdev);
> +       struct platform_device *ahci_pdev = priv->ahci_pdev;
> +
> +       platform_device_unregister(ahci_pdev);
> +       platform_set_drvdata(pdev, NULL);

ditto

-- 
With warm regards,
Sachin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
