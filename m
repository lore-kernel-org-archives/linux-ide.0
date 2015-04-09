From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: ahci_st: fixup layering violations / drvdata errors
Date: Thu, 09 Apr 2015 12:34:02 +0300
Message-ID: <5526478A.6060707@cogentembedded.com>
References: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kernel@stlinux.com, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-ide@vger.kernel.org

Hello.

On 4/8/2015 9:59 PM, Brian Norris wrote:

> When working on another SATA driver that uses libahci_platform, I
> noticed an error in this driver; it tries to the the driver data for its
> device, while libata also thinks it can set the driver data. See:

>    ahci_platform_init_host()
>    -> ata_host_alloc_pinfo()
>       -> ata_host_alloc()
>          -> dev_set_drvdata()

> So instead of sticking the IP-specific platform data into drvdata, let's
> use the plat_data variable that is reserved for this use.

> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> ---
> This is ONLY compile tested; I don't have hardware to run. This looks like it
> could have ramifications on suspend/resume support, and hot device removal
> (e.g., sysfs unbind), so it might qualify as -stable, if someone can test it

>   drivers/ata/ahci_st.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> index bc971af262e7..2bd2375c2ab1 100644
> --- a/drivers/ata/ahci_st.c
> +++ b/drivers/ata/ahci_st.c
[...]
> @@ -107,7 +108,9 @@ static void st_ahci_host_stop(struct ata_host *host)
>
>   static int st_ahci_probe_resets(struct platform_device *pdev)
>   {
> -	struct st_ahci_drv_data *drv_data = platform_get_drvdata(pdev);
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);

    Why not just platform_get_drvdata()?

[...]

MBR, Sergei
