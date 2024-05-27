Received: from devnull.tasossah.com (devnull.tasossah.com [91.121.165.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B36BFC0
	for <linux-ide@vger.kernel.org>; Mon, 27 May 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.165.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800471; cv=none; b=hHXBS68G9Qr4IdixQnnV7s6qqkY2/wZvaWwpZmGgxTjefrBxrFhPqFBzCmvHCkiIpZUOxfh0JhIA5WUjwY78+ZPrF+wWhnMzrkLPSTOOK/ZtyP598HIp4WWez8H13yeXuOSx1I37AtmvlaM3JD6Evw3ZwBug8wPxNjJlPgExAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800471; c=relaxed/simple;
	bh=PftEowrZgO0iHGoHGpMtkAcNlKUXKStTHWfT3cfdjn0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MmQcIZ2RpM1eXRpLaK+8t2x1cS5105ib9p5HSsxmn+3qplieJfdSsUOORZXlA+lr3+LJLEeVox1NBhzZbyJgU7sMGsUH86cXPl9+FxcsWSrilZW6HNaxpZDffAM3L1BkFoF/pETsLqScrEj+DwIq2t5r141rlS1MUGFGwE/a7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (1024-bit key) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b=qnNjyGKt; arc=none smtp.client-ip=91.121.165.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b="qnNjyGKt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=devnull.tasossah.com; s=vps; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zn8e2lzIXAa9cXDw5JjbYAXgfi5XzfopzQtK1GT/ur8=; b=qnNjyGKtr2luvX+oQou/0Xk/dE
	Ua0BUb/xG/yiozLjQHEA8gXOYzcI+6DEyteYp4uUzD9jdR/MWonnPRyOzqEkOSlb3iSckxo8Psn/f
	R17tOLUF0EDUvjnOhFmGv7xks0vlvD05WYE+jt7yDypBgzl1qmw1BXxFUjkgu3Irufl4=;
Received: from [2a02:587:6a04:fe00::298]
	by devnull.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <tasos@tasossah.com>)
	id 1sBWCp-0037IY-7J; Mon, 27 May 2024 11:59:47 +0300
Message-ID: <a32a43a4-c482-4689-9852-85da4d936641@tasossah.com>
Date: Mon, 27 May 2024 11:59:44 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tasos Sahanidis <tasos@tasossah.com>
Subject: Re: AHCI hotplug no longer functions on ICH7
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, jhp@endlessos.org, hch@lst.de,
 mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
 linux-ide@vger.kernel.org
References: <c41c5bf8-9ed8-49c8-a9f4-431d523fffbf@tasossah.com>
 <Zkyl/RuvygEpVW26@x1-carbon.wireless.wdc>
Content-Language: el-GR, en-GB
Autocrypt: addr=tasos@tasossah.com; keydata=
 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
In-Reply-To: <Zkyl/RuvygEpVW26@x1-carbon.wireless.wdc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas,

Thank you kindly for your response.

On 2024-05-21 16:47, Niklas Cassel wrote:
> If your port is external or hot plug capable, then your platform firmware/BIOS
> should set either the "PORT_CMD_ESP and HOST_CAP_SXS" bits or the
> "PORT_CMD_HPCP" bit.
> 
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=45b96d65ec68f625ad26ee16d2f556e29f715005

Understood. I had looked at that commit, but did not look into those
bits in detail. They were obviously not set correctly, thus the port was 
not marked external.

> Is there any option in your BIOS to mark the port as external or hot plug
> capable?
> 
> 
> If not, then your platform firmware is broken and needs to be quirked.
> 
> Please provde the output from
> # dmidecode
> so that we can apply a quirk for your broken platform.

I went through again and checked for any "hotplug" or "external" options
and found nothing. I was ready to try to make a quirk for it, but then I
noticed the option "ALPE and ASP" under IDE Configuration (section 
4.3.6, page 4-17 of the user's manual [0]). It was set to enabled, so I 
disabled it. That did the trick and the ports are now marked as 
external.

It looks like that option doesn't actually enable any kind of LPM, 
because otherwise hotplug would not have worked before, but rather 
expects the OS to enable/disable it.

> In older kernels, regardless if your AHCI controller reported support for
> low-power modes or not, you also needed an explicit entry in ahci_pci_tbl for
> it to be enabled.
> 
> Thus, even if you built with CONFIG_SATA_MOBILE_LPM_POLICY=3, and LPM was
> being reported as supported by your AHCI controller, LPM was most likely not
> enabled for your AHCI controller with older kernels.
> 
> In newer kernels, if CONFIG_SATA_MOBILE_LPM_POLICY=3, and the AHCI controller
> reports that it supports LPM, we will enable it.
> (We will not enable LPM if the port is external or hot plug capable, as that
> breaks hot plug, as you found out.)

That is indeed true, yes. Thank you for the explanation. The Ven/Dev
pair is not in the list of the LPM quirked ones in the original commit.

> According to the AHCI specification, a port that is external or hot plug
> capable should set the "PORT_CMD_ESP and HOST_CAP_SXS" bits or the
> "PORT_CMD_HPCP" bit.
> 
> If your platform fails to follow the AHCI specification, then it will need to
> be quirked.
> 
> 
> Kind regards,
> Niklas

After changing that setting and removing mobile_lpm_policy=0, hotplug 
still functions as expected, so no quirk is needed.

Thank you for your time, and apologies for not noticing this earlier.
Perhaps this helps someone in the future with the same issue.

[0] https://dlcdnets.asus.com/pub/ASUS/mb/socket775/P5W%20DH%20Deluxe/e2557_p5w_dh_dlx.pdf?model=P5W%20DH%20Deluxe

--
Tasos
