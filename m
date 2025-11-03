Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AF2417E0
	for <linux-ide@vger.kernel.org>; Mon,  3 Nov 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176453; cv=none; b=Yn5BoNlYthc5TS/m5FORBqjncadjWWr6OHN9Ce/QjbTCb4coL6UU1r9Y/XUe2mAw6fCRXk8Ghe4IT5XUtkpN2YLwkOzmaAvYAhw498lwBIPeJM+Ylp5tbnfFBWnhBXvcBi7ADlTaAqgfmqGaNA3l/5kQWf8lkLEPnh6IKqkKYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176453; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Zu6wpleG2t9CJb5oD3ykkm72sZAyGujb8eMIf2vY6l1wXjWgJNmTXbFN6HsyTYeaYMYYo4bfnDVEAsMjDYln+0CCozHd2hdVbHOvcHDUtfg/vWwP4wkqoxh9a6NkbeKiL4IiKxVX7jTnpMqn8aZPcd6QBqkB3lhh/JEiotYsv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.15.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4d0XSZ0pfHz8ty0
	for <linux-ide@vger.kernel.org>; Tue,  4 Nov 2025 00:27:25 +1100 (AEDT)
Message-ID: <946154fc-52db-453b-bdd7-4dd94b08bd0e@eyal.emu.id.au>
Date: Tue, 4 Nov 2025 00:27:24 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Content-Language: en-US
To: "linux-ide-owner@vger.kernel.org >> list linux-ide"
 <linux-ide@vger.kernel.org>
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: subscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

subscribe

