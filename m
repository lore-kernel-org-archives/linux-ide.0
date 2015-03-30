From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [V7 PATCH 1/3] ACPICA: Add ACPI _CLS processing
Date: Mon, 30 Mar 2015 09:17:10 -0500
Message-ID: <55195AE6.2050801@amd.com>
References: <1427397195-15273-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1427397195-15273-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2A5F70@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2A5F70@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "leo.duran@amd.com" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-ide@vger.kernel.org

On 3/27/2015 12:51 PM, Moore, Robert wrote:
> +	cls_objects = obj_desc->package.elements;
> +
> +	if (obj_desc->common.type == ACPI_TYPE_PACKAGE &&
> +	    obj_desc->package.count == 3 &&
> +	    cls_objects[0]->common.type == ACPI_TYPE_INTEGER &&
> +	    cls_objects[1]->common.type == ACPI_TYPE_INTEGER &&
> +	    cls_objects[2]->common.type == ACPI_TYPE_INTEGER) {
> +
> +		/* Allocate a buffer for the CLS */
> +		cls = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
> +					 (acpi_size) 7);
>
> I would like to see an error returned if an object or subobject is of the incorrect type.
> Then, the caller knows not to attempt to look at it.
>

Ok. I will return AE_TYPE if the condition is false here.

Thanks,

Suravee

