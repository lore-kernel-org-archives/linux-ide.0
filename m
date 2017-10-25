From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fixes kernel crash while tracing
 ata_eh_link_autopsy event
Date: Wed, 25 Oct 2017 07:54:50 -0700
Message-ID: <20171025145450.GA59538@devbig577.frc2.facebook.com>
References: <1508926976-11467-1-git-send-email-rsahu@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508926976-11467-1-git-send-email-rsahu@apm.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Rameshwar Prasad Sahu <rsahu@apm.com>
Cc: olof@lixom.net, arnd@arndb.de, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com
List-Id: linux-ide@vger.kernel.org

Hello,

On Wed, Oct 25, 2017 at 03:52:56PM +0530, Rameshwar Prasad Sahu wrote:
> @@ -288,8 +289,8 @@
>  	),
> 
>  	TP_fast_assign(
> -		__entry->ata_port	= dev->link->ap->print_id;
> -		__entry->ata_dev	= dev->link->pmp + dev->devno;
> +		__entry->ata_port	= link->ap->print_id;
> +		__entry->ata_dev	= link->pmp + link->device->devno;

The above is wrong if there are multiple devices on the link.  It
probably should take both link and dev and use dev iff it's not NULL.

Thanks.

-- 
tejun
