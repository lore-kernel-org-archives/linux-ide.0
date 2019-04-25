From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] drivers: nvme: target: core: fix build break
Date: Thu, 25 Apr 2019 01:00:46 +0000
Message-ID: <SN6PR04MB452772B2864B2074DDB018ED863D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1556102081-11820-1-git-send-email-info@metux.net>
 <1556102081-11820-2-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

Thanks for the fix Enrico. I'm still wondering on what platform=0A=
you got this error ?=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/24/2019 03:35 AM, Enrico Weigelt, metux IT consult wrote:=0A=
> Build breaks:=0A=
>=0A=
>      drivers/nvme/target/core.c: In function 'nvmet_req_alloc_sgl':=0A=
>      drivers/nvme/target/core.c:939:12: error: implicit declaration of \=
=0A=
> function 'sgl_alloc'; did you mean 'bio_alloc'? \=0A=
> [-Werror=3Dimplicit-function-declaration]=0A=
>        req->sg =3D sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt)=
;=0A=
>                  ^~~~~~~~~=0A=
>                  bio_alloc=0A=
>      drivers/nvme/target/core.c:939:10: warning: assignment makes pointer=
 \=0A=
> from integer without a cast [-Wint-conversion]=0A=
>        req->sg =3D sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt)=
;=0A=
>                ^=0A=
>      drivers/nvme/target/core.c: In function 'nvmet_req_free_sgl':=0A=
>      drivers/nvme/target/core.c:952:3: error: implicit declaration of \=
=0A=
> function 'sgl_free'; did you mean 'ida_free'? [-Werror=3Dimplicit-functio=
n-declaration]=0A=
>         sgl_free(req->sg);=0A=
>         ^~~~~~~~=0A=
>         ida_free=0A=
>=0A=
> Cause:=0A=
>=0A=
>      1. missing include to <linux/scatterlist.h>=0A=
>      2. SGL_ALLOC needs to be enabled=0A=
>=0A=
> Therefore adding the missing include, as well as Kconfig dependency.=0A=
>=0A=
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>=0A=
> ---=0A=
>   drivers/nvme/target/Kconfig | 1 +=0A=
>   drivers/nvme/target/core.c  | 1 +=0A=
>   2 files changed, 2 insertions(+)=0A=
>=0A=
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig=0A=
> index d94f25c..3ef0a4e 100644=0A=
> --- a/drivers/nvme/target/Kconfig=0A=
> +++ b/drivers/nvme/target/Kconfig=0A=
> @@ -3,6 +3,7 @@ config NVME_TARGET=0A=
>   	tristate "NVMe Target support"=0A=
>   	depends on BLOCK=0A=
>   	depends on CONFIGFS_FS=0A=
> +	select SGL_ALLOC=0A=
>   	help=0A=
>   	  This enabled target side support for the NVMe protocol, that is=0A=
>   	  it allows the Linux kernel to implement NVMe subsystems and=0A=
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
> index b3e765a..08851f5 100644=0A=
> --- a/drivers/nvme/target/core.c=0A=
> +++ b/drivers/nvme/target/core.c=0A=
> @@ -8,6 +8,7 @@=0A=
>   #include <linux/random.h>=0A=
>   #include <linux/rculist.h>=0A=
>   #include <linux/pci-p2pdma.h>=0A=
> +#include <linux/scatterlist.h>=0A=
>=0A=
>   #include "nvmet.h"=0A=
>=0A=
>=0A=
=0A=
