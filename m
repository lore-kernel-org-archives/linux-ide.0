From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] ata: implement MODE SELECT command
Date: Wed, 04 Jul 2012 21:34:47 +0200
Message-ID: <4FF49AD7.20102@redhat.com>
References: <1341400436-2546-1-git-send-email-pbonzini@redhat.com> <4FF4637A.6060901@mvista.com> <4FF46951.7050808@redhat.com> <4FF47B71.4030603@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FF47B71.4030603@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

Il 04/07/2012 19:20, Sergei Shtylyov ha scritto:
>> > Perhaps for MODE SENSE, but not for MODE SELECT.  Otherwise, where do
>> > you get the mode data from?
>    They simply don't change?

The standard says "If the parameter list length results in the
truncation of any mode parameter header, mode parameter block
descriptor(s), or mode page, then the command shall be terminated with
CHECK CONDITION status, with the sense key set to ILLEGAL REQUEST, and
the additional sense code set to PARAMETER LIST LENGTH ERROR".

Paolo
