From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [V8 PATCH 1/3] ACPICA: Add ACPI _CLS processing
Date: Fri, 24 Apr 2015 16:08:31 -0500
Message-ID: <553AB0CF.1010904@amd.com>
References: <1427752579-19234-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1427752579-19234-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1AE640813FDE7649BE1B193DEA596E8802704682@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802704682@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Moore, Robert" <robert.moore@intel.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "leo.duran@amd.com" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-ide@vger.kernel.org

On 4/16/15 20:45, Zheng, Lv wrote:
> Before back porting this to ACPICA, let me ask one simple question.
> According to the spec, the _CLS is optional and PCI specific.
> So why should we implement it in ACPICA core not OSPM specific modules?
> If this need to be implemented in ACPICA, then what about the following device identification objects?
> _DDN, _HRV, _MLS, _PLD, _STR, _SUN
>
> Thanks and best regards
> -Lv

Hi,

Sorry for late reply. As for the justification for introducing the _CLS 
support in the ACPICA, this is mainly because ACPI does not currently 
define _CID for certain device classes, which used to mostly be PCI 
devices. Instead, ACPI spec mentioned that _CLS can be used for loading 
generic drivers on hardware that is compatible with PCI-defined device 
classes, but that is not implemented on the PCI bus (and is therefore 
enumerated by ACPI.)

The code introduced for supporting _CLS is also similar in the way 
ACPICA is currently parsing the _CID or _SUB (which are also optional), 
and using it for the same purpose of identifying devices for loading 
drivers.

Also, since this method for identifying devices is OS-independent, I 
believe this should not be done in the OSPM specific modules.

Thanks,

Suravee
