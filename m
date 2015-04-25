From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [V8 PATCH 1/3] ACPICA: Add ACPI _CLS processing
Date: Sat, 25 Apr 2015 04:28:57 +0200
Message-ID: <1960107.SMA7G3OmSP@vostro.rjw.lan>
References: <1427752579-19234-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1AE640813FDE7649BE1B193DEA596E8802704682@SHSMSX101.ccr.corp.intel.com> <553AB0CF.1010904@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57570 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755821AbbDYCEN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2015 22:04:13 -0400
In-Reply-To: <553AB0CF.1010904@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Moore, Robert" <robert.moore@intel.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "leo.duran@amd.com" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Friday, April 24, 2015 04:08:31 PM Suravee Suthikulpanit wrote:
> On 4/16/15 20:45, Zheng, Lv wrote:
> > Before back porting this to ACPICA, let me ask one simple question.
> > According to the spec, the _CLS is optional and PCI specific.
> > So why should we implement it in ACPICA core not OSPM specific modules?
> > If this need to be implemented in ACPICA, then what about the following device identification objects?
> > _DDN, _HRV, _MLS, _PLD, _STR, _SUN
> >
> > Thanks and best regards
> > -Lv
> 
> Hi,
> 
> Sorry for late reply. As for the justification for introducing the _CLS 
> support in the ACPICA, this is mainly because ACPI does not currently 
> define _CID for certain device classes, which used to mostly be PCI 
> devices. Instead, ACPI spec mentioned that _CLS can be used for loading 
> generic drivers on hardware that is compatible with PCI-defined device 
> classes, but that is not implemented on the PCI bus (and is therefore 
> enumerated by ACPI.)

I think it would be good to point to the particular part of the spec
making that provision.  In what section is that mentioned, exactly?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
