Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB913B5AE
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993025; cv=none; b=e16j7K/i0YvA/ymsxzJiWYEUK2yPSKmab3Bwit1PAqQsRDgjZFRiy/FaeYyr3O83LEHQdr+oJt2gepnQXj6Zl6htwoNbc0jjluZzOiuHI2e1/VFCmHGAvRLeM2H1QJeIXZGqxKilbFkHcwhtYUyO/0Ty9kFhiqy86KfIRDFNnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993025; c=relaxed/simple;
	bh=g3w3Tso/v/0w2ygisx+WBduPcsMuiZqkxxm3w8elGhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raTFIJV1Eu9pBk5hYcjUELsI5l9WyDYUNd7nNVQHI8V81TOIs5VJkuY/kiGE4tonC+aWSLCj0ZdHawcD9NMKCQBBC0+7gunVO+d1i7aGspqUCoa9UwlEll5LnwAiegJKajR/Z3W0dsBgpn8ahVKQE20x0aU9mMmP+v5xu+POU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwgej9u6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwgej9u6"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so7327518a12.3
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725993021; x=1726597821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8v5Hd0GafvR7eRw+F0b/pQqT5Z7153+Dlo66ZdBXwCc=;
        b=fwgej9u6OEaSODOdjmtWHSy36aVJ7bx12nrjcs5c9nia1ycC1CV67feJHQ7FE54lBa
         Fa2cGwt2b5X9C8j78JWoNcbKu1UgzPX4YGOxlku+onfJFRp3vwLVhhlffTyk8aWCwzTf
         8gFHOelzODZFTR1QyS9kS4V45SKB8RBjySgjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993021; x=1726597821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8v5Hd0GafvR7eRw+F0b/pQqT5Z7153+Dlo66ZdBXwCc=;
        b=TGgbA2adMmm9y/bQkmz3nmQZuFjtKKFbs2WqA5hJfzlrnCkzTEtP5kxI2qlyOKMPsZ
         2ErhXbIT/YnI/YEkEPHIyJLZyXU8+GkdPRGFiUl2sIiN790VXAOayxSd7VaLOOr3vSAa
         laLj4VqqZiuGOHUWEluFOWPmkRyNYyhv14p0G3WE8npLlOeStLamDnsUUvwK/4JV2XR5
         bGO7cGwKx2GMax1/LVK/MugrGGHraj12NIj3YmD3gPH0XiaiPHgxFTkhfp+O9aFtKzcR
         lOLghoFN8x+cAZlCw/l1XMPwOo0o2Uy8x5Xc2oCD3Iwz53Tw0YYgTr2+iDx3F6Obm9jH
         lOpw==
X-Forwarded-Encrypted: i=1; AJvYcCVUYlxcb5JngH8mn3rGdjoUJV5d+Qggg/dqLjlSAmZV/3/Ro4yUrNmxLgEkAxdPZBQu5vOsVDjUM4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZYgNKc6pcj5FQyi47gMz+nlfM/NrNC0Vg4hOHe87Ad34dLQB
	tGh9HAH3Xk7X9z7P8U0jf88aWQnL4tKV0o2OeTQRq8Ruu3yOeQ2CIlNnn7psE75r9XiTUBcKgqD
	6weM=
X-Google-Smtp-Source: AGHT+IHx6FBeA0lykYesnd5e5zmNstbR8fmP/Mm7eXD3vqv8H7yVh6G+NEY2TSXOnhzebf1Lgz5t6A==
X-Received: by 2002:a17:906:4fc4:b0:a86:9c41:cfc1 with SMTP id a640c23a62f3a-a8ffaa9a888mr193636966b.8.1725993020082;
        Tue, 10 Sep 2024 11:30:20 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583558esm512801166b.1.2024.09.10.11.30.19
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:30:19 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so7327470a12.3
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 11:30:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgV0fKNXbJxOPvsxJHV7Wz6SPkav8HfTMzm4sFdm6c0K8My/oqb6Xand1tJhC9peBIuXP06UUi/aE=@vger.kernel.org
X-Received: by 2002:a05:6402:34c4:b0:5be:cdaf:1c09 with SMTP id
 4fb4d7f45d1cf-5c3dc7baef3mr12220681a12.28.1725993019011; Tue, 10 Sep 2024
 11:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org> <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
In-Reply-To: <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 10 Sep 2024 11:30:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO9kMbiKLcD3fY0Yt5PJSPD=9NVH0cs=xQFSk8dU9Z1Q@mail.gmail.com>
Message-ID: <CAHk-=wgO9kMbiKLcD3fY0Yt5PJSPD=9NVH0cs=xQFSk8dU9Z1Q@mail.gmail.com>
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Netdev <netdev@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-ide@vger.kernel.org, cassel@kernel.org, handan.babu@oracle.com, 
	djwong@kernel.org, Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 10:53, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit

Just for fun - can you test moving the queue freezing *inside* the
mutex, ie something like

  --- a/block/blk-sysfs.c
  +++ b/block/blk-sysfs.c
  @@ -670,11 +670,11 @@ queue_attr_store(struct kobject *kobj, struct
attribute *attr,
          if (!entry->store)
                  return -EIO;

  -       blk_mq_freeze_queue(q);
          mutex_lock(&q->sysfs_lock);
  +       blk_mq_freeze_queue(q);
          res = entry->store(disk, page, length);
  -       mutex_unlock(&q->sysfs_lock);
          blk_mq_unfreeze_queue(q);
  +       mutex_unlock(&q->sysfs_lock);
          return res;
   }

(Just do it by hand, my patch is whitespace-damaged on purpose -
untested and not well thought through).

Because I'm wondering whether maybe some IO is done under the
sysfs_lock, and then you might have a deadlock?

              Linus
