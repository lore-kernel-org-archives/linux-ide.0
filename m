From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] libata: allow sata_sil24 to opt-out of tag ordered
 submission
Date: Sat, 17 Jan 2015 21:43:01 +0300
Message-ID: <54BAAD35.9010502@cogentembedded.com>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>	<20150116231302.18771.62862.stgit@viggo.jf.intel.com>	<54BA409E.4040901@cogentembedded.com> <CAPcyv4h3n+cnvADiEbGgi1EFCqEwhzZ7gt_6XUmSC62aOf2Dzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4h3n+cnvADiEbGgi1EFCqEwhzZ7gt_6XUmSC62aOf2Dzw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Ronny Hegewald <Ronny.Hegewald@online.de>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 01/17/2015 09:35 PM, Dan Williams wrote:

>  >> Ronny reports: https://bugzilla.kernel.org/show_bug.cgi?id=87101
>  >>      "Since commit 8a4aeec8d "libata/ahci: accommodate tag ordered
>  >>      controllers" the access to the harddisk on the first SATA-port is
>  >>      failing on its first access. The access to the harddisk on the
>  >>      second port is working normal.

>  >>      When reverting the above commit, access to both harddisks is working
>  >>      fine again."

>  >> Maintain tag ordered submission as the default, but allow sata_sil24 to
>  >> continue with the old behavior.

>  >> Cc: <stable@vger.kernel.org <mailto:stable@vger.kernel.org>>
>  >> Cc: Tejun Heo <tj@kernel.org <mailto:tj@kernel.org>>
>  >> Reported-by: Ronny Hegewald <Ronny.Hegewald@online.de>
>  >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>  >> ---
>  >>   drivers/ata/libata-core.c |    5 ++++-
>  >>   drivers/ata/sata_sil24.c  |    2 +-
>  >>   include/linux/libata.h    |    1 +
>  >>   3 files changed, 6 insertions(+), 2 deletions(-)

>  >> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>  >> index 5c84fb5c3372..e2085d4b5b93 100644
>  >> --- a/drivers/ata/libata-core.c
>  >> +++ b/drivers/ata/libata-core.c
>  >> @@ -4748,7 +4748,10 @@ static struct ata_queued_cmd *ata_qc_new(struct
> ata_port *ap)
>  >>                 return NULL;
>  >>
>  >>         for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
>  >> -               tag = tag < max_queue ? tag : 0;
>  >> +               if (ap->flags & ATA_FLAG_LOWTAG)
>  >> +                       tag = i;
>  >> +               else
>  >> +                       tag = tag < max_queue ? tag : 0;

>  >    Ugh, this is clear abuse of the ?: operator... Why not simply:

>  >                 else if (tag >= max_queue)
>  >                         tag = 0;

> "Abuse"!? Let's just call it "creative differences adding in a minimal quirk
> while neglecting to refactor" ;-).

    In fact, the old code had the same abuse, I didn't notice that...

> Sure, that's cleaner.

    Thanks. :-)

MBR, Sergei
