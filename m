Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BC29CA;
	Thu, 27 Jun 2024 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468991; cv=none; b=ctZX6lDMU4LCgQtGX3LBIeb72zuEMzv0CoTV6gV1L09I+wapVBLJT8j+Eqbe5YB+Dmlu2AT6VoySco9iyFhEhBiQ/kxwQSAbHBnBQXBAC+cM8yuvtPOiyHzZrmr56rh555b8lWAO9H+VNXjQkf6ppD7c16WGnwo3y1VcsIACYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468991; c=relaxed/simple;
	bh=uStK4bFp1BPin+zNYPwNaCH4ut4a2Au5mdIuK9G8ZUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QD/2edryLSiU/n7bEJAAGlgFFMcPeGooihdkeMjfenmaqNOU4xCFppA4FJUIxPMptsu1ZCTS7CoL2ew3P6FY9/5ePD0DVGC3zqQwxZEuUFDp8aG1JOyh0QKxRHcQLL5nz88EkukEvZzoFT04rXqknMBEm0c1duuOegF1kyHGkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BIbMi16G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DdVrG8uZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BIbMi16G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DdVrG8uZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BIbMi16G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DdVrG8uZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BIbMi16G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DdVrG8uZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0496C21B6A;
	Thu, 27 Jun 2024 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719468988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqLx8hiOZuHA84CFKopQohb2JmOfZlNQt11qDXNollo=;
	b=BIbMi16GPx1Dq1zIjSd6qnhcMcBkzkKGVTgabblfiET3yE4xZEZ2OV4TUJF76Beb1LqGYF
	9WMOXY5Go1h0giZfQazuS2Gqvn7FVqXwn2elRwEgS2KinPJuDYWwkgTnVNtNJurv5/2QVt
	1Xzg9Xxznn3xm7xhJtbamdNTpvutedc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719468988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqLx8hiOZuHA84CFKopQohb2JmOfZlNQt11qDXNollo=;
	b=DdVrG8uZVMsSWOuLjMwd5XIvTi0GV9MRnghdFVoQ5GqFO8oCpPIAOCJ6X5utzCnrgChzMW
	dNIyn/JKYWe7p3Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BIbMi16G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DdVrG8uZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719468988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqLx8hiOZuHA84CFKopQohb2JmOfZlNQt11qDXNollo=;
	b=BIbMi16GPx1Dq1zIjSd6qnhcMcBkzkKGVTgabblfiET3yE4xZEZ2OV4TUJF76Beb1LqGYF
	9WMOXY5Go1h0giZfQazuS2Gqvn7FVqXwn2elRwEgS2KinPJuDYWwkgTnVNtNJurv5/2QVt
	1Xzg9Xxznn3xm7xhJtbamdNTpvutedc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719468988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqLx8hiOZuHA84CFKopQohb2JmOfZlNQt11qDXNollo=;
	b=DdVrG8uZVMsSWOuLjMwd5XIvTi0GV9MRnghdFVoQ5GqFO8oCpPIAOCJ6X5utzCnrgChzMW
	dNIyn/JKYWe7p3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83E5D137DF;
	Thu, 27 Jun 2024 06:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3irHLsDfWanZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Jun 2024 06:16:27 +0000
Message-ID: <a4fe9092-a934-4cea-bdcd-f3f387deb195@suse.de>
Date: Thu, 27 Jun 2024 08:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-7-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240626230411.3471543-7-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0496C21B6A
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/27/24 01:04, Igor Pylypiv wrote:
> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-scsi.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

