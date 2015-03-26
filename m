From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [V6 PATCH 1/3] ACPICA: Add ACPI _CLS processing
Date: Thu, 26 Mar 2015 19:01:58 +0800
Message-ID: <5513E726.6010505@huawei.com>
References: <1427316368-20965-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1427316368-20965-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:28125 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbCZLCU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2015 07:02:20 -0400
In-Reply-To: <1427316368-20965-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, robert.moore@intel.com, lv.zheng@intel.com
Cc: lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015/3/26 4:46, Suravee Suthikulpanit wrote:
> ACPI Device configuration often contain _CLS object to suppy PCI-defined
> class code for the device. This patch introduces logic to process the _CLS
> object.
>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

