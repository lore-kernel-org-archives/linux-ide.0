From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 02/12] libata: bind the Linux device tree to the ACPI
 device tree
Date: Thu, 21 Jun 2012 08:40:15 -0700
Message-ID: <CABE8wwtDDip2ZY63JPz9J3iJUk6goL6eAHskNAWkLaBp+QcyCg@mail.gmail.com>
References: <1340000766-129148-1-git-send-email-ming.m.lin@intel.com>
	<1340000766-129148-3-git-send-email-ming.m.lin@intel.com>
	<CAA9_cmcX2pajewz1v864Ni2Z3XAy8UrCRg+mg3Y2qFEd2j=nDg@mail.gmail.com>
	<1340242002.20081.84.camel@minggr>
	<CAA9_cmfCVTWtqfDY4PAzK_yaVWXLV+oMO1qt_AtQKp2upPUX=Q@mail.gmail.com>
	<1340260626.24067.4.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1340260626.24067.4.camel@minggr>
Sender: linux-scsi-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Aaron Lu <aaron.lu@amd.com>, Holger Macht <holger@homac.de>, Matthew Garrett <mjg@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <David.Woodhouse@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Jun 20, 2012 at 11:37 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> Good idea.
>
> Below is the incremental patch on top of this series.
>

Looks good, I like your additional change to pass a sdev to
ata_acpi_bind_device.

--
Dan
