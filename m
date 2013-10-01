From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 2/3] Phy: Exynos: Add Exynos5250 sata phy driver
Date: Tue, 1 Oct 2013 13:45:04 +0530
Message-ID: <CAK9yfHzpiU+ugak6escnn2ioAq8yvTjK7RzrQaUrL7cwwq_EMA@mail.gmail.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
	<1380609183-21430-3-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1380609183-21430-3-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: tj@kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, GIRISH K S <ks.giri@samsung.com>, "aditya.ps" <aditya.ps@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hi Yuvaraj,

On 1 October 2013 12:03, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:

> +static int exynos_sata_i2c_remove(struct i2c_client *client)
> +{
> +       dev_info(&client->adapter->dev,
> +               "detached %s from i2c adapter successfully\n",
> +               client->name);
> +
> +       return 0;
> +}
> +

Since this function does not do anything, this could be removed.

> +static const struct i2c_device_id phy_i2c_device_match[] = {
> +       { "sata-phy-i2c", 0 },
> +};
> +MODULE_DEVICE_TABLE(of, phy_i2c_device_match);
> +
> +struct i2c_driver sataphy_i2c_driver = {
> +       .probe    = exynos_sata_i2c_probe,
> +       .id_table = phy_i2c_device_match,
> +       .remove         = exynos_sata_i2c_remove,
> +       .driver   = {
> +               .name = "sata-phy-i2c",
> +               .owner = THIS_MODULE,
> +               .of_match_table = (void *)phy_i2c_device_match,

type casting is not required.

-- 
With warm regards,
Sachin
