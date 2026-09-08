Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A654B1DF
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878099; cv=none; b=uR6va1Ba1XBZ/oAzn9BLQ+Wqt6yfLfD3pry/eHrs5L+q3FDgSBKOfDXN/o0TqDdVlIkKEavu1aR72D0Y4PLR1mZbd5eBbfR2qnqZ10dDdf5f6c5hkTxRY3K3Qsp4aZNhjUL5uGr00LVDx/0iK/569SIq4d/Z1QGJAUTMg3QRuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878099; c=relaxed/simple;
	bh=5OoymxO5vNcnF0bjzul1XaRAGkLV7l75YsaDb7h26sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZ5SbfwGXnxpn8UAY2UMX5g8w8e3qQcbs0zYetz0zerkYJKbNDqIOrkniwnxHOVZE3fkOwHF8TMG77Qdh4wzD3ysaqY6nGDc/pnAVhAwocP4pnmqt09m4n1PPsG77ouvv6pEVX9F7tC2DpHLu552RTCExEOIczX5sXUcBTHVI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CSFsfTjH; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CSFsfTjH"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso4315235e9.0
        for <linux-ide@vger.kernel.org>; Tue, 08 Sep 2026 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788878093; x=1789482893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0AhYrfnw2FLiSHKTmeRhquOA1Zcxh/wrV83CYUv+wmY=;
        b=CSFsfTjHzbSvCGLeNokAeEDoi9aycAJV94vG5gomvkTNY2jiUSgC+dspFbixx8h6Sw
         yCK43sH27KVdZ4iJM4SeN5ZCsRcaWuwAiaEsyc7caC6g4L04vNr3P6amFv0NyWr+qmsN
         0BOybbsvz3EiTNDXLzlIYxR+PpTC4sRqoqhI91R5WAkN8f2lPDL29buYkMo5wp6Wubg+
         HBGb9YkKrAtJ1OL+uaotG5egMnrXLeD9ZmXMfSVu1caSrVKoebo5ViEfljSgfGUCh/sf
         /GhGk82avbD+VVksOfek1il5PYC6PCSGArJiNwlb6/7vbctfAarS4H2sgjlLI5gigAvB
         kATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788878093; x=1789482893;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0AhYrfnw2FLiSHKTmeRhquOA1Zcxh/wrV83CYUv+wmY=;
        b=SbGwnOmrNhayZgd2oLHqu6dzR4JJWMWUs6PxfdtpQlsfiW9PpvkSI3TdsUU0eqqjH9
         ETgZHI8AekXhz7TdTwtz3gFh/tO2dDsPwamSVl+3K2qXs3JORs8iZunt7Br3FOa6Elqr
         fYmkSbwGqxuwyN9+T7ji5j3OCOvsjmnSLXVmTsjPvG/vhjj0TAeM4B0WNtu42Op0a1Ce
         XOO8deVVDYXpRCoGJ+5OLnQxn8yqpMdj1SuXmpBmZ1bZkn1+j9PEPi+waTaESDlhXuYe
         vsS0JOoc7mdeg9FOFYvx0Wp/SyghHT/lPYB7JM7yy7N5UC9318uotwiuvN2R8hBLZ8m9
         p2Zw==
X-Forwarded-Encrypted: i=1; AKwUvBzYh3YbLqgg89O9ZevumZcxusH7ld54atvjdeJ4P/AI5WjSsE47+jwOSwzGszYbCxw1j0ehuj/+las=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ20aE6TU6xRnb8qK7zX0zGDj4p8vYTxccAQDD/RkYAlRz8iHA
	teQUPnSgsmPx3fqF76ZVyt3FTNHCGwVEzhKX+lXvHKEE4g5eZtkwKIiYua+kEP/jHOM=
X-Gm-Gg: AYBFou0ABpJ/lLYo3/nGyF1kE3f6P3YNhV4CIUU4X0aV37kR0nBpvEk23Vzc3nkhXtZ
	LmDUxJnVEzS0vmPGSPHoZqj+AbGzp83mFti8xegswiApxVM6NDMknAyvtSLlZVshQWZ8m368+tw
	uhR7HijR/SijVuBh4S1ufrNPoy32pTEYoHiSV0msdmODcLA299meTif1rgcFQGQBdW1DGnT2QZR
	DqQZfEEHl9rg/TGWseDBgw4XfG/SyrS5QO7EotIKLhjrIklmPYwQvsPiQVjTBkupxLnL47fp+6U
	ahJi+TELOMJvjXAF3h32Nh0V+xyjWxP4lM/zoo95TMWtbAGyBXw0x4UecV6lvWeq1dwUv6+Hvt5
	M9O8XtbBKtTdOHjlLWZN6HynSLhLJ+167NCXEKo3+8aCIWOPtdfmw39/EDbXor/Q5/S5UKTd4SC
	XwJDoagOgyky0r2TQ45wLiouQro2sZq4Q7MOL5FjaWVt//oMyzj45VVBy0eKGParAxouGlsACxa
	GqyCxaFFIpUpg==
X-Received: by 2002:a05:600c:1908:b0:49c:f13e:e4f with SMTP id 5b1f17b1804b1-49d1757b03dmr65089625e9.12.1788878092317;
        Tue, 08 Sep 2026 07:34:52 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm563758395e9.13.2026.09.08.07.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 07:34:52 -0700 (PDT)
Message-ID: <8e426afc-b534-454f-9880-2b25764f370a@suse.com>
Date: Tue, 8 Sep 2026 17:34:51 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_dwc_460ex: Don't enable interrupt if libATA
 core registration fails
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
References: <20260908141538.731237-1-nik.borisov@suse.com>
 <20260908143042.964151F00A3D@smtp.kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260908143042.964151F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.26 г. 17:30 ч., sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [Low] The patch introduces a `goto err;` statement in `sata_dwc_probe()`, but there is no label named `err:` defined in the function, resulting in a compilation error.

Fair point, however I'd like to hear from an expert whether enabling the 
interrupt without properly registering with libata core is fine or not? 
I.e whether this particular fix makes sense?

<snip>
