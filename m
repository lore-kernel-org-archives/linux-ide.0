Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E283186A
	for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2025 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275162; cv=none; b=WXNjoE59FQu2/ZP3MIZGJBxcoi0vvCbltIUDmgVNgb3jpw0FTUekbW8dNXSTLGQRJGSiVBFg2xDFyLyGtzoaZ9jO0IGwRfMxYGYSNLJu0Ms3jbv+VoRQ+QNFOq5Iu73o582IXTZSU18cNzOzVz6IXrrjYtAQH6+vpaoNtvqZkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275162; c=relaxed/simple;
	bh=/TmxxXGWFlIeusd6nrjDbcxI3N36R3b0PTAH9116H8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6ahD4Sr2wjuomqrXQ9dQTUgOebfvC4BuD1IaKM0sfudwG4bmTaegW6panU2SQArtnaTujbE5C4sbYZfx02FQ77lQavqEVDzc2lfw3YboL+7SKKiH7vYvPTUJvBgFdJw8KygRjy83vxj9mQeAu4YkdDXmwr2/Z9ickljwF7fZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1Ayto0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1Ayto0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB9DC4CEDD;
	Tue, 18 Mar 2025 05:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742275161;
	bh=/TmxxXGWFlIeusd6nrjDbcxI3N36R3b0PTAH9116H8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l1Ayto0avx+fUTLzEBVP2yiguMAHaWAtBME/ZFrklqYZzH0rLx6kg8IdFVSJs1ZDM
	 frTcodrCeBUF/q7Z0NZEFi3jJhX1z2UFPD9KNmLi3L+IZEfvY0H56kv7VNC1jm4bUn
	 vQxlv4msuRY+k2kgweWND3nNu2mYXWMZY91rpgTtW0QGJLfBkvJENkLfwHiu01fjeV
	 Xp5mklnABWeTbR/pm4En+g+n4aLwvDEs/0/5GZPnFfEVjESdu2bruNKfTUZdKNNjo8
	 4h+0bv7Fc22vcHfW0xKlQ6OiKyv/Ib0H+P9icoowxwd0VdmHiDcFb+mJ6LW3+ViS5i
	 2aFtAP001nE5A==
Message-ID: <5db1373b-3136-4a43-a986-24715a8c5d18@kernel.org>
Date: Tue, 18 Mar 2025 14:18:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: Fix NCQ Non-Data log not supported print
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20250317111754.1666084-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250317111754.1666084-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 8:17 PM, Niklas Cassel wrote:
> Currently, both ata_dev_config_ncq_send_recv() - which checks for NCQ
> Send/Recv Log (Log Address 13h) and ata_dev_config_ncq_non_data() -
> which checks for NCQ Non-Data Log (Log Address 12h), uses the same
> print when the log is not supported:
> 
>   "NCQ Send/Recv Log not supported"
> 
> This seems like a copy paste error, since NCQ Non-Data Log is actually
> a separate log.
> 
> Fix the print the reference the correct log.
> 
> Fixes: 284b3b77ea88 ("libata: NCQ encapsulation for ZAC MANAGEMENT OUT")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
